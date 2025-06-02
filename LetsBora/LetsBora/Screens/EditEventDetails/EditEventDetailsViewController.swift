//
//  EditEventDetailsViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/05/25.
//

import UIKit
import CoreLocation

class EditEventViewController: UIViewController, EditEventViewDelegate {

    private var screen: EditEventDetailsView!
    private var viewModel: EditEventViewModel!
    
    init(viewModel: EditEventViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        screen = EditEventDetailsView()
        screen.delegate = self
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Editar Evento"
        populateViewWithEventData()
    }
    
    private func populateViewWithEventData() {
        screen.configure(with: viewModel.event)
    }
    
    var onDismissAndUpdate: ((_ updatedEvent: Event) -> Void)?
    
    func didTapSave() {
        guard let screen = self.screen else { // Garante que a screen existe
            print("Erro: A tela (screen) não está disponível.")
            // Você pode querer mostrar um alerta aqui também
            return
        }

        screen.resetAllErrorVisuals()
        var isValid = true

        // --- Declare variáveis para guardar os dados validados/coletados ---
        // O título é pego do viewModel, pois não há campo para editá-lo na view atual.
        let titleToSave = self.viewModel.event.title
        var dateToSave: Date?
        var locationDetailsToSave: EventLocationDetails?
        var descriptionToSave: String?
        var costToSave: String?

        // --- Validação e Coleta de Dados ---

        // 1. Data e Hora
        if let selectedDateFromPicker = screen.selectedDate { // Usa a propriedade da view
            // Validação de exemplo: data deve ser no futuro (não pode ser no passado).
            // Permite "hoje" se a hora ainda não passou.
            if selectedDateFromPicker < Date() && !Calendar.current.isDateInToday(selectedDateFromPicker) { // Estritamente antes de hoje
                screen.displayDateError("A data do evento não pode ser no passado.")
                isValid = false
            } else if Calendar.current.isDateInToday(selectedDateFromPicker) && selectedDateFromPicker < Date() { // Hoje, mas a hora já passou
                 screen.displayDateError("A hora para o evento de hoje já passou.")
                 isValid = false
            }
            // Se passou na validação (ou se não houve erro específico acima que invalidou)
            if isValid { // Rechecar isValid caso a validação de data tenha falhado
                dateToSave = selectedDateFromPicker
            }
        } else {
            screen.displayDateError("Data e hora são obrigatórias.")
            isValid = false
        }
        
        // 2. Localização (Nome e Endereço)
        let locationNameText = screen.locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let addressText = screen.addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if locationNameText.isEmpty && !addressText.isEmpty {
            screen.displayLocationError("Informe o nome do local se o endereço foi fornecido.")
            isValid = false
        } else if !locationNameText.isEmpty && addressText.isEmpty {
            screen.displayAddressError("Se informou o nome do local, forneça também o endereço.")
            isValid = false
        }
        
        // Validação adicional: Se um local é obrigatório, e ambos estão vazios.
        // Se for opcional, você pode pular esta parte ou ajustar.
        // Assumindo que se o usuário preencheu algo, ele quer um local, ou se era obrigatório:
        if (viewModel.event.locationDetails != nil || !locationNameText.isEmpty || !addressText.isEmpty) && (locationNameText.isEmpty && addressText.isEmpty) {
             // Se havia um local antes, ou se o usuário tentou limpar ambos os campos
             // quando um local é considerado 'presente' (mesmo que com nome/endereço vazios).
             // Esta lógica pode precisar de ajuste fino baseado se "limpar o local" é uma ação válida.
             // Por ora, se o local é obrigatório:
            // screen.displayLocationError("Localização (nome e endereço) é obrigatória.")
            // isValid = false
        }


        // Construir locationDetailsToSave APÓS a validação dos campos de texto
        // e somente se a seção de localização for considerada válida até aqui.
        // Se locationNameText e addressText são ambos vazios, locationDetailsToSave será nil (se local for opcional).
        // Se local for obrigatório, 'isValid' já teria sido setado para false acima.
        if !locationNameText.isEmpty || !addressText.isEmpty {
            locationDetailsToSave = EventLocationDetails(
                name: locationNameText.isEmpty ? nil : locationNameText,
                address: addressText.isEmpty ? nil : addressText,
                latitude: viewModel.event.locationDetails?.latitude ?? 0.0, // Mantém coordenadas originais
                longitude: viewModel.event.locationDetails?.longitude ?? 0.0 // Mantém coordenadas originais
            )
        } else {
            // Se ambos locationNameText e addressText forem vazios,
            // locationDetailsToSave permanecerá nil. Isso é ok se o local for opcional.
            // Se o local fosse obrigatório, 'isValid' já seria false.
        }


        // 3. Descrição
        let descriptionTextValue = screen.descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if descriptionTextValue.isEmpty {
            screen.displayDescriptionError("Descrição é obrigatória.")
            isValid = false
        } else if descriptionTextValue.count < 10 {
            screen.displayDescriptionError("Descrição deve ter pelo menos 10 caracteres.")
            isValid = false
        } else {
            descriptionToSave = descriptionTextValue
        }

        // 4. Custo
        let costTextValue = screen.costTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if costTextValue.isEmpty {
            // Custo é opcional, então 'nil' é um valor válido para 'costToSave'.
            // Se fosse obrigatório:
            // screen.displayCostError("Custo é obrigatório.")
            // isValid = false
            costToSave = nil // ou "" se a propriedade no Event for String não opcional e você preferir string vazia
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            // Tenta converter vírgula para ponto para o NumberFormatter
            if formatter.number(from: costTextValue.replacingOccurrences(of: ",", with: ".")) == nil && !(costTextValue.lowercased() == "grátis") {
                screen.displayCostError("Formato de custo inválido. Use números (ex: 20.50) ou 'Grátis'.")
                isValid = false
            } else {
                costToSave = costTextValue
            }
        }

        // --- Atualizar ViewModel e Dispensar Tela se Válido ---
        if isValid {
            viewModel.updateEvent(
                title: titleToSave, // Título não é editável nesta tela, então usamos o original.
                date: dateToSave,
                location: locationDetailsToSave, // Certifique-se que o nome do parâmetro é 'locationDetails'
                description: descriptionToSave,
                totalCost: costToSave
            )
            
            // Chamar o closure para notificar a tela anterior
            onDismissAndUpdate?(viewModel.event)
            
            print("Evento atualizado. ViewModel notificado.")
            navigationController?.popViewController(animated: true)
        } else {
            // Se 'isValid' for false, os erros já foram exibidos pelos métodos display...Error.
            // Um alerta geral pode ser útil para resumir.
            let alert = UIAlertController(title: "Campos Inválidos",
                                          message: "Por favor, corrija os campos destacados e tente novamente.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    func didTapCancel() {
        dismiss(animated: true)
    }
}

