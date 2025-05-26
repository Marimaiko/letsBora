import UIKit

class CreateEventViewController: UIViewController {

    var screen: CreateEventView?
    
    // Propriedades para armazenar os dados do evento
    private var eventName: String?
    private var eventDescription: String?
    private var eventDateTime: Date? // Data e Hora combinadas
    private var eventLocationName: String? // Nome do local selecionado
    private var eventCategoryName: String? // Nome da categoria selecionada
    private var isEventPrivate: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func loadView() {
        screen = CreateEventView()
        screen?.delegate = self
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        
        // Configurar delegate para o TextView de descrição
        screen?.descriptionEventTextView.delegate = self
        
        // Inicializar o placeholder da descrição (se o texto estiver vazio)
        updateDescriptionPlaceholder()
        
        // Adicionar targets para os botões de Localização e Categoria (se forem abrir novas telas)
        // screen?.locationCustomContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationTapped)))
        // screen?.categoryCustomContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTapped)))
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
        // Alternativamente, se você atualiza o label do CustomContainer:
        /*
        if screen.locationCustomContainer.getLabelName() == "Localização" { // Precisa de um método getLabelName() em CustomContainer
            screen.locationErrorLabel.text = "Localização é obrigatória."
            screen.locationErrorLabel.isHidden = false
            isValid = false
        }
        */


        // 5. Validar Categoria (Similar à localização)
        if eventCategoryName == nil || eventCategoryName!.isEmpty {
            screen.categoryErrorLabel.text = "Categoria é obrigatória."
            screen.categoryErrorLabel.isHidden = false
            isValid = false
        }
        /*
        if screen.categoryCustomContainer.getLabelName() == "Categoria" {
            screen.categoryErrorLabel.text = "Categoria é obrigatória."
            screen.categoryErrorLabel.isHidden = false
            isValid = false
        }
        */

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
        // Lógica para salvar rascunho, pode ter validações menos estritas ou nenhuma
        print("Salvando rascunho...")
        // Colete os dados atuais dos campos, mesmo que inválidos para publicação
        let name = screen?.nameEventTextField.text
        // ... etc.
        showAlert(title: "Rascunho", message: "Evento salvo como rascunho!")
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
    
    func didTapCategoryContainer() {
        print("Container de Categoria tocado. Abrir tela de seleção de categoria.")
        // Exemplo: Navegar para um CategoryPickerViewController
        // let categoryPickerVC = CategoryPickerViewController()
        // categoryPickerVC.delegate = self // Para receber a categoria selecionada
        // self.navigationController?.pushViewController(categoryPickerVC, animated: true)
        
        // --- MOCK PARA TESTE DE VALIDAÇÃO ---
        // Simular que uma categoria foi selecionada
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let mockCategory = "Festa"
            self.eventCategoryName = mockCategory
            self.screen?.categoryCustomContainer.updateLabelName(newName: mockCategory)
            self.screen?.categoryErrorLabel.isHidden = true
            print("Categoria mock selecionada: \(mockCategory)")
        }
        // --- FIM DO MOCK ---
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
            // screen?.descriptionErrorLabel.isHidden = true
            // screen?.descriptionEventTextView.layer.borderColor = UIColor.systemGray4.cgColor
            // screen?.descriptionEventTextView.layer.borderWidth = 0.5
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // A validação principal ocorrerá ao tentar publicar.
        // Mas você pode adicionar alguma validação leve aqui se desejar.
    }
}


//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})



