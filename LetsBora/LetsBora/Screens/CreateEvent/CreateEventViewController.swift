import UIKit

class CreateEventViewController: UIViewController {
    
    var screen: CreateEventView?
    var viewModel: CreateEventViewModel?
    
    // Propriedades para armazenar os dados do evento
    private var eventName: String?
    private var eventDescription: String?
    private var eventDateTime: Date?
    private var eventLocationName: String?
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

        // 4. Validar Localização (Verifica se o label foi alterado do padrão)
        // Esta é uma validação simples. Idealmente, você teria um valor selecionado.
        if eventLocationName == nil || eventLocationName!.isEmpty {
             screen.locationErrorLabel.text = "Localização é obrigatória."
             screen.locationErrorLabel.isHidden = false
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
        // Aqui você tem todos os dados validados:
        // self.eventName
        // self.eventDescription
        // self.eventDateTime
        // self.eventLocationName
        // self.eventCategoryName
        // self.isEventPrivate
        
        print("Validação OK! Dados para criar evento:")
        print("Nome: \(self.eventName ?? "N/A")")
        print("Descrição: \(self.eventDescription ?? "N/A")")
        if let date = self.eventDateTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            print("Data/Hora: \(formatter.string(from: date))")
        }
        print("Local: \(self.eventLocationName ?? "N/A")")
        print("Categoria: \(self.eventCategoryName ?? "N/A")")
        print("Privado: \(self.isEventPrivate)")
        
        // Chame sua API, salve no CoreData, etc.
        showAlert(title: "Sucesso!", message: "Evento pronto para ser criado/publicado!")
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
        
        // self.eventDateTime, self.eventLocationName, self.eventCategoryName já devem estar
        // sendo atualizados pelas interações do usuário através dos métodos de delegate.
        let draftDateTime = self.eventDateTime
        let draftLocationName = self.eventLocationName
        let draftCategoryName = self.eventCategoryName
        
        let draftIsPrivate = screen.eventPrivacySwitch.isOn

        // 2. Criar um objeto de rascunho (usando a struct EventDraft)
        let draft = EventDraft(
            name: draftName,
            description: draftDescription,
            dateTime: draftDateTime,
            locationName: draftLocationName,
            categoryName: draftCategoryName,
            isPrivate: draftIsPrivate
        )

        // 3. Lógica de Salvamento (Placeholder - Implemente conforme sua necessidade)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(draft)
            UserDefaults.standard.set(data, forKey: "eventDraft")
            print("Rascunho salvo no UserDefaults!")
            // Mostrar alerta de sucesso após o salvamento real
            showAlert(title: "Rascunho Salvo", message: "Seu evento foi salvo como rascunho.")
        } catch {
            print("Erro ao salvar rascunho no UserDefaults: \(error)")
            showAlert(title: "Erro", message: "Não foi possível salvar o rascunho.")
        }
        
        // Apenas para debug, você pode imprimir o rascunho:
//        print("Dados do Rascunho:")
//        print("- Nome: \(draft.name ?? "N/A")")
//        print("- Descrição: \(draft.description ?? "N/A")")
//        if let date = draft.dateTime {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .medium
//            formatter.timeStyle = .short
//            print("- Data/Hora: \(formatter.string(from: date))")
//        } else {
//            print("- Data/Hora: N/A")
//        }
//        print("- Local: \(draft.locationName ?? "N/A")")
//        print("- Categoria: \(draft.categoryName ?? "N/A")")
//        print("- Privado: \(draft.isPrivate)")
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
                updateDescriptionPlaceholder() // Atualiza a visibilidade do placeholder da descrição
                
                if let dateTime = loadedDraft.dateTime {
                    self.eventDateTime = dateTime
                    // Atualizar o label do dateCustomContainer
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm" // Mesmo formato usado ao confirmar
                    screen.dateCustomContainer.updateLabelName(newName: dateFormatter.string(from: dateTime))
                }
                
                if let locationName = loadedDraft.locationName, !locationName.isEmpty {
                    self.eventLocationName = locationName
                    screen.locationCustomContainer.updateLabelName(newName: locationName)
                }
                
                if let categoryName = loadedDraft.categoryName, !categoryName.isEmpty {
                    self.eventCategoryName = categoryName
                    screen.categoryCustomContainer.updateLabelName(newName: categoryName)
                }
                
                screen.eventPrivacySwitch.setOn(loadedDraft.isPrivate, animated: false)
                self.isEventPrivate = loadedDraft.isPrivate
                
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
                // Limpar erro de data/hora se estiver visível e a data for válida
                if combinedDate > Date() {
                    screen?.dateTimeErrorLabel.isHidden = true
                }
            }
        }
        print("Data e hora confirmadas pelo ViewController: \(String(describing: self.eventDateTime))")
    }
    
    func publishEventTapped() {
        print("Botão Publicar Evento Tocado no ViewController")
        if validateInputs() {
            proceedWithEventCreation()
        } else {
            print("Validação falhou.")
            // Opcional: Role para o primeiro erro
        }
    }
    
    func saveDraftTapped() {
        print("Botão Salvar Rascunho Tocado no ViewController")
        saveDraft()
    }
    
    func didTapLocationContainer() {
        print("Container de Localização tocado. Abrir tela de seleção de local.")
        // Exemplo: Navegar para um LocationPickerViewController
        // let locationPickerVC = LocationPickerViewController()
        // locationPickerVC.delegate = self // Para receber o local selecionado
        // self.navigationController?.pushViewController(locationPickerVC, animated: true)
        
        // --- MOCK PARA TESTE DE VALIDAÇÃO ---
        // Simular que um local foi selecionado após um tempo
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let mockLocation = "Shopping Iguatemi Bosque"
            self.eventLocationName = mockLocation
            self.screen?.locationCustomContainer.updateLabelName(newName: mockLocation)
            self.screen?.locationErrorLabel.isHidden = true 
            print("Localização mock selecionada: \(mockLocation)")
        }
        // --- FIM DO MOCK ---
    }
    
    func didSelectCategory(_ category: String) { // Novo método do delegate
        self.eventCategoryName = category
        print("Categoria selecionada pelo ViewController: \(category)")
        // Limpar erro da categoria, se houver
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
                 // screen?.descriptionErrorLabel.isHidden = true
                 // screen?.descriptionEventTextView.layer.borderColor = UIColor.systemGray4.cgColor
                 // screen?.descriptionEventTextView.layer.borderWidth = 0.5
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == screen?.descriptionEventTextView {
            // Pode-se remover o erro ao começar a editar
             screen?.descriptionErrorLabel.isHidden = true
             screen?.descriptionEventTextView.layer.borderColor = UIColor.systemGray4.cgColor
             screen?.descriptionEventTextView.layer.borderWidth = 0.5
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // A validação principal ocorrerá ao tentar publicar.
        // Mas você pode adicionar alguma validação leve aqui se desejar.
    }
}

struct EventDraft: Codable {
    let name: String?
    let description: String?
    let dateTime: Date?
    let locationName: String?
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
