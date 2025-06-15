import UIKit
import CoreLocation

class CreateEventViewController: UIViewController {
    
    var screen: CreateEventView?
    var viewModel: CreateEventViewModel?
    
    private lazy var alert: AlertController = {
        let alert = AlertController(controller: self)
        return alert
    }()
    
    // MARK: -  Propriedades para armazenar os dados do evento
    private var eventName: String?
    private var eventDescription: String?
    private var eventDateTime: Date?
    private var eventLocation: EventLocationDetails?
    private var eventCategory: Tag?
    private var eventGuestNames: [User] = []
    private var isEventPrivate: Bool = false
    
    // MARK: - LyfeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func loadView() {
        viewModel = CreateEventViewModel()
        screen = CreateEventView()
        view = screen
        /*
        Task {
            screen?.categories = await viewModel?.getTags() ?? []
        }
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(inject: self)
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        
        // Configurar delegate para o TextView de descrição
        screen?.descriptionEventTextView.delegate = self
        
        // Tenta carregar um rascunho ao iniciar a tela
        loadDraft()
        /*
        // Se nenhum rascunho for carregado, o placeholder da descrição precisa ser checado:
        if screen?.descriptionEventTextView.text.isEmpty ?? true {
            updateDescriptionPlaceholder()
        }
         */
    }
    
    // MARK: - Functions
/*
    private func updateDescriptionPlaceholder() {
        screen?.descriptionEventTextView.set = !(screen?.descriptionEventTextView.text.isEmpty ?? true)
    }
  */
    // Função para validar todos os campos
    private func validateInputs() -> Bool {
        guard let screen = screen else { return false }
        var isValid = true
        
        screen.resetAllErrorVisuals() // Limpa erros anteriores
        
        // 1. Validar Nome do Evento
        let name = screen.nameEventTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if name.isEmpty {
            screen.nameEventErrorLabel.text = "Nome do evento é obrigatório."
            screen.nameEventErrorLabel.isHidden = false
            screen.nameEventTextField.layer.borderColor = UIColor.red.cgColor
            screen.nameEventTextField.layer.borderWidth = 1.0
            isValid = false
        } else if name.count < 3 {
            screen.nameEventErrorLabel.text = "Nome do evento deve ter pelo menos 3 caracteres."
            screen.nameEventErrorLabel.isHidden = false
            screen.nameEventTextField.layer.borderColor = UIColor.red.cgColor
            screen.nameEventTextField.layer.borderWidth = 1.0
            isValid = false
        } else {
            self.eventName = name
        }
        
        // 2. Validar Descrição
        let description = screen.descriptionEventTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if description.isEmpty {
            screen.descriptionErrorLabel.text = "Descrição é obrigatória."
            screen.descriptionErrorLabel.isHidden = false
            screen.descriptionEventTextView.layer.borderColor = UIColor.red.cgColor
            screen.descriptionEventTextView.layer.borderWidth = 1.0
            isValid = false
        } else if description.count < 10 {
            screen.descriptionErrorLabel.text = "Descrição deve ter pelo menos 10 caracteres."
            screen.descriptionErrorLabel.isHidden = false
            screen.descriptionEventTextView.layer.borderColor = UIColor.red.cgColor
            screen.descriptionEventTextView.layer.borderWidth = 1.0
            isValid = false
        } else {
            self.eventDescription = description
        }
        
        // 3. Validar Data e Hora
        if eventDateTime == nil {
            screen.dateTimeErrorLabel.text = "Data e hora são obrigatórias."
            screen.dateTimeErrorLabel.isHidden = false
            // Adicionar borda ao dateCustomContainer se desejar
            isValid = false
        } else if let selectedDate = eventDateTime, selectedDate <= Date() {
            screen.dateTimeErrorLabel.text = "A data e hora do evento devem ser futuras."
            screen.dateTimeErrorLabel.isHidden = false
            isValid = false
        }

        // 4. Validar Localização
                if eventLocation == nil {
                     screen.locationErrorLabel.text = "Localização é obrigatória."
                     screen.locationErrorLabel.isHidden = false
                     // Adicionar destaque visual ao locationCustomContainer se desejar
                     // screen.locationCustomContainer.layer.borderColor = UIColor.red.cgColor
                     // screen.locationCustomContainer.layer.borderWidth = 1.0
                     isValid = false
                }

        // 5. Validar Categoria (Similar à localização)
        if eventCategory?.title == nil || eventCategory?.title == ""{
            print(eventCategory ?? "Nenhum")
            screen.categoryErrorLabel.text = "Categoria é obrigatória."
            screen.categoryErrorLabel.isHidden = false
            isValid = false
        }
        
        // 6. Privacidade (O switch já tem um valor, 'isEventPrivate' será atualizado)
        self.isEventPrivate = screen.eventPrivacySwitch.isOn
        
        if !isValid {
            // Opcional: Mostrar um alerta geral se preferir, além dos labels individuais
            // showAlert(title: "Campos Inválidos", message: "Por favor, corrija os campos destacados.")
        }
        
        return isValid
    }
    
    private func proceedWithEventCreation() {

        if let date = self.eventDateTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            print("Data/Hora: \(formatter.string(from: date))")
        }

        guard let name = self.eventName,
            let dateTime = self.eventDateTime,
            let location = self.eventLocation,
            let category = self.eventCategory
        else {
            alert.showAlert(title: "Erro Interno", message: "Alguns dados do evento estão faltando.")
            return
        }
        
        let newEvent = Event(
            title: name,
            image: nil, // TODO: Adicionar lógica para imagem
            tag: category,   // // should be a tag instead string
            visibility: self.isEventPrivate ? "Privado" : "Público",
            date: dateTime.toString(),
            locationDetails: location, // Usar o objeto EventLocationDetails
            description: self.eventDescription,
            totalCost: nil, // TODO: Adicionar lógica para custo
            participants: eventGuestNames,
            owner: Utils.getLoggedInUser()
        )

        Task {
            do {
                try await viewModel?.saveEvent(event: newEvent)
                alert.showAlert(title: "Sucesso!", message: "Evento criado com sucesso!")
            } catch {
                alert.showAlert(title: "Erro", message: "Falha ao salvar o evento: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveDraft() {
        guard let screen = screen else {
            print("Erro: A tela (screen) não está disponível para salvar o rascunho.")
            alert.showAlert(title: "Erro", message: "Não foi possível salvar o rascunho.")
            return
        }
        
        print("Iniciando salvamento do rascunho...")
        
        // 1. Coletar os dados atuais dos campos
        let draftName = screen.nameEventTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let draftDescription = screen.descriptionEventTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let draftDateTime = self.eventDateTime
        // let draftCategory = self.eventCategory
        let draftIsPrivate = screen.eventPrivacySwitch.isOn
        
        // 2. Criar um objeto de rascunho (usando a struct EventDraft)
        let draft = EventDraft(
            name: draftName,
            description: draftDescription,
            dateTime: draftDateTime,
            locationDetails: self.eventLocation,
            category: eventCategory,
            isPrivate: draftIsPrivate
        )
        
        // 3. Lógica de Salvamento (Placeholder - Implemente conforme sua necessidade)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(draft)
            UserDefaults.standard.set(data, forKey: "eventDraft")
            alert.showAlert(title: "Rascunho Salvo", message: "Seu evento foi salvo como rascunho.")
        } catch {
            alert.showAlert(title: "Erro", message: "Não foi possível salvar o rascunho.")
        }
    }
    
    // Função para carregar o rascunho
    func loadDraft() {
        guard let screen = screen else { return }
        
        // Exemplo carregando de UserDefaults:
        if let savedData = UserDefaults.standard.data(forKey: "eventDraft") {
            do {
                let decoder = JSONDecoder()
                let loadedDraft = try decoder.decode(EventDraft.self, from: savedData)
                print("Rascunho carregado!")
                
                screen.nameEventTextField.text = loadedDraft.name
                screen.descriptionEventTextView.text = loadedDraft.description
                
                self.eventDateTime = loadedDraft.dateTime
                if let dateTime = loadedDraft.dateTime {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
                    screen.dateCustomContainer.updateLabelName(newName: dateFormatter.string(from: dateTime))
                }
                
                // Carregar locationDetails
                self.eventLocation = loadedDraft.locationDetails
                if let location = loadedDraft.locationDetails {
                    screen.locationCustomContainer.updateLabelName(newName: location.displayString)
                }
                
                self.eventCategory = loadedDraft.category
                if let categoryName = loadedDraft.category?.title, !categoryName.isEmpty {
                    screen.categoryCustomContainer.updateLabelName(newName: categoryName)
                    // TODO: Atualizar o picker se necessário
                }
                
                screen.eventPrivacySwitch.setOn(loadedDraft.isPrivate, animated: false)
                self.isEventPrivate = loadedDraft.isPrivate
                
                //updateDescriptionPlaceholder() // Chamar após preencher descrição
                //alert.showAlert(title: "Rascunho Carregado", message: "Os dados do rascunho foram preenchidos.")
            } catch {
                print("Erro ao carregar rascunho do UserDefaults: \(error)")
            }
        } else {
            print("Nenhum rascunho encontrado.")
        }
    }
    
    
}

//MARK: - CreateEventViewDelegate
extension CreateEventViewController: CreateEventViewDelegate {
    func didTapPublishButton() {
        if validateInputs() {
            proceedWithEventCreation()
        } else {
            print("Validação falhou.")
            // Opcional: Role para o primeiro erro
        }
    }
    
    func didTapDraftButton() {
        saveDraft()
    }
    
    func didTapCategoryContainer() {
        Task {
            [weak self] in
            guard let self = self else { return }
            // update avaible tags
            let tags = await self.viewModel?.getTags()
            
            let categoryViewController = CategoryViewController(
                option: tags,
                initialOption: self.eventCategory ?? nil
            )
            
            // closure to update category
            categoryViewController.onSelectCategory = { [weak self] selectedCategory in
                guard let self else {return}
                
                self.eventCategory = selectedCategory
                self.screen?.categoryCustomContainer.updateLabelName(
                    newName: selectedCategory.title
                )
            }
            
            // present
            let categoryNavigationController = UINavigationController(
                rootViewController: categoryViewController
            )
            categoryNavigationController.modalPresentationStyle = .automatic
            if let sheet = categoryNavigationController.sheetPresentationController {
                sheet.detents = [
                    .custom { context in
                        return context.maximumDetentValue * 0.25
                    }
                ]
                sheet.prefersGrabberVisible = true
            }
            self.present(categoryNavigationController, animated: true)
        }
    }
    
    func didTapCalendarContainer() {
        Task{
            [weak self] in
            guard let self = self else { return }
            let calendarViewController = CalendarViewController(
                with: eventDateTime
            )
            
            // closure to update date
            calendarViewController.onSelectDate = {[weak self] date in
                guard let self = self else { return }
                self.eventDateTime = date
                self.screen?.dateCustomContainer
                    .updateLabelName(
                        newName:date.toString()
                    )
            }
            
            // present with navigation bar
            let calendarNavigationController = UINavigationController(
                rootViewController: calendarViewController
            )
            calendarNavigationController.modalPresentationStyle = .formSheet
            
            if let sheet = calendarNavigationController.sheetPresentationController {
                sheet.detents = [
                    .custom { context in
                        return context.maximumDetentValue * 0.75
                    }
                ]
                sheet.prefersGrabberVisible = true
            }
            self.present(calendarNavigationController, animated: true)
        }
    }
    
    func didTapInviteButton() {
        Task{[weak self] in
            guard let self = self else { return }
            
            let guests = await self.viewModel?.fetchUsers() ?? []
            let guestModalViewController = CreateEventGuestModalViewController(
                guests: guests,
                selectedGuests: self.eventGuestNames
            )
            guestModalViewController
                .onGuestsSelected = {[weak self] selectedGuests in
                guard let self = self else { return }
                
                print("Selected guests: \(selectedGuests.map({$0.name}))")
                self.eventGuestNames = selectedGuests
                self.screen?.setAvatars(selectedGuests.map({$0.photo ?? ""}))
                
            }
            // present with navigation bar
            let guestModalNavigationController = UINavigationController(
                rootViewController: guestModalViewController
            )
            guestModalNavigationController.modalPresentationStyle = .formSheet
            self.present(guestModalNavigationController, animated: true)
        }
    }
    
    func didConfirmDateTime(date: Date, time: Date) {
        // A view já combinou e formatou em 'selectedDateAndTime'
        // Mas se precisar dos componentes separados:
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        if let hour = timeComponents.hour, let minute = timeComponents.minute {
            if let combinedDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: date) {
                self.eventDateTime = combinedDate
                if combinedDate > Date() {
                    screen?.dateTimeErrorLabel.isHidden = true
                }
            }
        }
        print("Data e hora confirmadas pelo ViewController: \(String(describing: self.eventDateTime))")
    }
  
    func presentAddressAlert() async -> String? {
        return await withCheckedContinuation { continuation in
            let addressAlert = UIAlertController(title: "Adicione um endereço", message: nil, preferredStyle: .alert)
            
            addressAlert.addTextField { textField in
                textField.placeholder = "Endereço"
            }
            
            let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { _ in
                let address = addressAlert.textFields?.first?.text
                continuation.resume(returning: address)
            }
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                continuation.resume(returning: nil)
            }
            
            addressAlert.addAction(confirmAction)
            addressAlert.addAction(cancelAction)
            
            self.present(addressAlert, animated: true)
        }
    }
    
    func didTapLocationContainer() {
        let locationPickerVC = LocationPickerViewController()
        locationPickerVC.delegate = self
        let navigationControllerForPicker = UINavigationController(
            rootViewController: locationPickerVC
        )
        navigationControllerForPicker.modalPresentationStyle = .pageSheet // Ou .formSheet, .automatic
        if let sheet = navigationControllerForPicker.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        // APRESENTE O NAVIGATION CONTROLLER
        self.present(navigationControllerForPicker, animated: true, completion: nil)
    }
}

//MARK: - UITextViewDelegate
extension CreateEventViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == screen?.descriptionEventTextView {
            //updateDescriptionPlaceholder()
            // Opcional: Limpar erro de descrição enquanto o usuário digita
            if !(textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                screen?.descriptionErrorLabel.isHidden = true
                screen?.descriptionEventTextView.layer.borderColor = UIColor.systemGray4.cgColor
                screen?.descriptionEventTextView.layer.borderWidth = 0.5
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == screen?.descriptionEventTextView {
             screen?.descriptionErrorLabel.isHidden = true
             screen?.descriptionEventTextView.layer.borderColor = UIColor.systemGray4.cgColor
             screen?.descriptionEventTextView.layer.borderWidth = 0.5
        }
    }
}

extension CreateEventViewController: LocationPickerDelegate {
    func didSelectLocation(_ location: EventLocationDetails) {
        self.eventLocation = location
        self.screen?.locationCustomContainer.updateLabelName(newName: location.displayString)
        self.screen?.locationErrorLabel.isHidden = true // Limpa o erro
        // O LocationPickerViewController deve se dispensar após a seleção,
        // ou você pode dispensá-lo aqui:
        // presentedViewController?.dismiss(animated: true, completion: nil)
        print("Localização selecionada: \(location.displayString)")
    }
}

struct EventDraft: Codable {
    let name: String?
    let description: String?
    let dateTime: Date?
    let locationDetails: EventLocationDetails?
    let category: Tag?
    let isPrivate: Bool
}


//MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})

#endif
