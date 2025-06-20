import UIKit
import CoreLocation

class CreateEventViewController: UIViewController {
    
    var screen: CreateEventView?
    var viewModel: CreateEventViewModel?
    
    // Propriedades para armazenar os dados do evento
    private var eventName: String?
    private var eventDescription: String?
    private var eventDateTime: Date?
    private var eventLocation: EventLocationDetails?
    private var eventCategoryName: String?
    private var isEventPrivate: Bool = false
    
    // Lista de categorias
       private let availableCategories: [String] = ["Festa", "Esporte", "Reunião", "Show", "Cultural", "Curso/Workshop", "Religioso", "Outro"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func loadView() {
        screen = CreateEventView()
        view = screen
        screen?.categories = availableCategories
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(inject: self)
        viewModel = CreateEventViewModel()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        
        // Configurar delegate para o TextView de descrição
        screen?.descriptionEventTextView.delegate = self
        
        // Tenta carregar um rascunho ao iniciar a tela
        loadDraft()
        // Se nenhum rascunho for carregado, o placeholder da descrição precisa ser checado:
        if screen?.descriptionEventTextView.text.isEmpty ?? true {
            updateDescriptionPlaceholder()
        }
    }
    
    private func updateDescriptionPlaceholder() {
        screen?.descriptionPlaceholderLabel.isHidden = !(screen?.descriptionEventTextView.text.isEmpty ?? true)
    }

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
        if eventCategoryName == nil || eventCategoryName!.isEmpty {
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
            let category = self.eventCategoryName
        else {
            showAlert(title: "Erro Interno", message: "Alguns dados do evento estão faltando.")
            return
        }
        
        let newEvent = Event(
            title: name,
            image: nil, // TODO: Adicionar lógica para imagem
            tag: nil,   // TODO: Definir o que é Tag
            visibility: self.isEventPrivate ? "Privado" : "Público",
            date: dateTime, 
            locationDetails: location, // Usar o objeto EventLocationDetails
            description: self.eventDescription,
            totalCost: nil, // TODO: Adicionar lógica para custo
            participants: nil, // TODO: Adicionar lógica para participantes
            owner: nil // TODO: Definir o owner (usuário logado)
        )
        
        print("Validação OK! Criando evento:")
                print("- Título: \(newEvent.title)")
                print("- Data: \(newEvent.date)")
                print("- Local: \(newEvent.locationDetails?.displayString ?? "N/A")")
                print("- Categoria: \(category)")
                print("- Privado: \(self.isEventPrivate)")
                print("- Descrição: \(newEvent.description ?? "N/A")")

                // Chamar o ViewModel para salvar o evento
                Task {
                    await viewModel?.saveEvent(event: newEvent)
                    await MainActor.run {
                        showAlert(title: "Sucesso!", message: "Evento publicado com sucesso!")
                        // Ex: self.navigationController?.popViewController(animated: true)
                        // ou resetar os campos para criar um novo evento.
                    }
                }
    }
    
    private func saveDraft() {
        guard let screen = screen else {
            print("Erro: A tela (screen) não está disponível para salvar o rascunho.")
            showAlert(title: "Erro", message: "Não foi possível salvar o rascunho.")
            return
        }

        print("Iniciando salvamento do rascunho...")

        // 1. Coletar os dados atuais dos campos
        let draftName = screen.nameEventTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let draftDescription = screen.descriptionEventTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let draftDateTime = self.eventDateTime
        let draftCategoryName = self.eventCategoryName
        let draftIsPrivate = screen.eventPrivacySwitch.isOn

        // 2. Criar um objeto de rascunho (usando a struct EventDraft)
        let draft = EventDraft(
            name: draftName,
            description: draftDescription,
            dateTime: draftDateTime,
            locationDetails: self.eventLocation,
            categoryName: draftCategoryName,
            isPrivate: draftIsPrivate
        )

        // 3. Lógica de Salvamento (Placeholder - Implemente conforme sua necessidade)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(draft)
            UserDefaults.standard.set(data, forKey: "eventDraft")
            showAlert(title: "Rascunho Salvo", message: "Seu evento foi salvo como rascunho.")
        } catch {
            showAlert(title: "Erro", message: "Não foi possível salvar o rascunho.")
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
                
                self.eventCategoryName = loadedDraft.categoryName
                if let categoryName = loadedDraft.categoryName, !categoryName.isEmpty {
                    screen.categoryCustomContainer.updateLabelName(newName: categoryName)
                    // TODO: Atualizar o picker se necessário
                }
                
                screen.eventPrivacySwitch.setOn(loadedDraft.isPrivate, animated: false)
                self.isEventPrivate = loadedDraft.isPrivate
                
                updateDescriptionPlaceholder() // Chamar após preencher descrição
                showAlert(title: "Rascunho Carregado", message: "Os dados do rascunho foram preenchidos.")
            } catch {
                print("Erro ao carregar rascunho do UserDefaults: \(error)")
            }
        } else {
            print("Nenhum rascunho encontrado.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - CreateEventViewDelegate
extension CreateEventViewController: CreateEventViewDelegate {
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
    
    func publishEventTapped() {
        if validateInputs() {
            proceedWithEventCreation()
        } else {
            print("Validação falhou.")
            // Opcional: Role para o primeiro erro
        }
    }
    
    func saveDraftTapped() {
        saveDraft()
    }
    
    func didTapLocationContainer() {
        let locationPickerVC = LocationPickerViewController()
        locationPickerVC.delegate = self
        let navigationControllerForPicker = UINavigationController(rootViewController: locationPickerVC)
        navigationControllerForPicker.modalPresentationStyle = .pageSheet // Ou .formSheet, .automatic
        if let sheet = navigationControllerForPicker.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        // APRESENTE O NAVIGATION CONTROLLER
        self.present(navigationControllerForPicker, animated: true, completion: nil)
    }
    
    func didSelectCategory(_ category: String) { // Novo método do delegate
        self.eventCategoryName = category
        if !(category.isEmpty) {
            screen?.categoryErrorLabel.isHidden = true
        }
    }
}

//MARK: - UITextViewDelegate
extension CreateEventViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == screen?.descriptionEventTextView {
            updateDescriptionPlaceholder()
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
    let categoryName: String?
    let isPrivate: Bool
}


//MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})

#endif
