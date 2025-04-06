//
//  CreateEventView.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 03/04/25.
//

import UIKit
import FSCalendar

class CreateEventView: UIView {

//MARK: - UIComponents
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Criar Evento"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var nameEventTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nome do evento"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return textField
    }()

    private lazy var descriptionEventTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        textView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        return textView
    }()

    private lazy var descriptionPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .placeholderText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Data e Hora <--
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        //Icon+Label
        textField.leftView = makeIconLabelView(iconName: "calendar", labelText: "Data e Hora")
        textField.leftViewMode = .always

        // Ícone seta à direita
        textField.rightView = makeArrowIconView()
        textField.rightViewMode = .always

        //Ação ao tocar
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        textField.addGestureRecognizer(tapGesture)

        return textField
    }()

    lazy var calendarContainerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .white
           view.layer.cornerRadius = 10
           view.layer.shadowColor = UIColor.black.cgColor
           view.layer.shadowOpacity = 0.2
           view.layer.shadowOffset = CGSize(width: 0, height: 2)
           view.isHidden = true
           return view
       }()

        let calendar: FSCalendar = {
            let calendar = FSCalendar()
            calendar.translatesAutoresizingMaskIntoConstraints = false
            calendar.appearance.headerTitleColor = .systemBlue
            calendar.appearance.weekdayTextColor = .darkGray
            calendar.appearance.selectionColor = .systemRed
            calendar.locale = Locale(identifier: "pt_BR")
        return calendar
    }()

       private let timePicker: UIDatePicker = {
           let picker = UIDatePicker()
           picker.translatesAutoresizingMaskIntoConstraints = false
           picker.datePickerMode = .time
           picker.preferredDatePickerStyle = .wheels
           return picker
       }()

        private lazy var confirmButton: UIButton = {
           let button = UIButton(type: .system)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Confirmar", for: .normal)
           button.setTitleColor(.systemBlue, for: .normal)
           button.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
           button.layer.cornerRadius = 8
           button.heightAnchor.constraint(equalToConstant: 44).isActive = true
           button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
           button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
           return button
       }()
    
    //Localização <--
    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        // Agora usando a função para criar o ícone + label
        textField.leftView = makeIconLabelView(iconName: "pin", labelText: "Localização")
        textField.leftViewMode = .always

        // Ícone seta à direita
        textField.rightView = makeArrowIconView()
        textField.rightViewMode = .always

        return textField
    }()

    
    //Categoria <--
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        // Container do ícone e label à esquerda
        textField.leftView = makeIconLabelView(iconName: "face.smiling", labelText: "Categoria")
        textField.leftViewMode = .always

        // Ícone seta à direita
        textField.rightView = makeArrowIconView()
        textField.rightViewMode = .always

        return textField
    }()

    private let categoryContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.isHidden = true // Inicialmente escondido
        return view
    }()
    
    //Público ou Privado <--
    private lazy var publicOrPrivateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        // LEFT: Ícone + Label
        textField.leftView = makeIconLabelView(iconName: "lock", labelText: "Evento Privado")
        textField.leftViewMode = .always

        // RIGHT: Switch criado manualmente
        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = .systemBlue
        switchView.translatesAutoresizingMaskIntoConstraints = false

        let switchContainer = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 42))
        switchContainer.addSubview(switchView)

        NSLayoutConstraint.activate([
            switchView.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: switchContainer.trailingAnchor, constant: -8)
        ])

        textField.rightView = switchContainer
        textField.rightViewMode = .always

        return textField
    }()
    
    //Convidar participantes <-
    private lazy var participantsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)

        // Ícone
        let iconImageView = UIImageView(image: UIImage(systemName: "person"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .black
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        // Label "Participantes"
        let titleLabel = UILabel()
        titleLabel.text = "Participantes"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16)

        // Botão "Convidar"
        let inviteButton = UIButton(type: .system)
        inviteButton.setTitle("Convidar", for: .normal)
        inviteButton.setTitleColor(.systemBlue, for: .normal)

        // Stack para ícone e label
        let titleStackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        titleStackView.axis = .horizontal
        titleStackView.spacing = 6
        titleStackView.alignment = .center

        // Stack horizontal com título + botão
        let topStackView = UIStackView(arrangedSubviews: [titleStackView, inviteButton])
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.distribution = .equalSpacing
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        // Stack de imagens dos participantes
        let participantsStackView = UIStackView()
        participantsStackView.axis = .horizontal
        participantsStackView.spacing = 8
        participantsStackView.distribution = .fill
        participantsStackView.alignment = .leading
        participantsStackView.translatesAutoresizingMaskIntoConstraints = false

        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 14
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray

            imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true

            // Garante que o imageView não tente expandir
            imageView.setContentHuggingPriority(.required, for: .horizontal)
            imageView.setContentCompressionResistancePriority(.required, for: .horizontal)

            participantsStackView.addArrangedSubview(imageView)
        }
        
        //Espaço para corrigir o alinhamento das fotos a esquerda
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        participantsStackView.addArrangedSubview(spacer)

        // Stack vertical geral
        let contentStack = UIStackView(arrangedSubviews: [topStackView, participantsStackView])
        contentStack.axis = .vertical
        contentStack.spacing = 12
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            contentStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        return containerView
    }()

    //Botões <--
    private lazy var actionButtonsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear

        // Botão Confirmar
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Publicar Evento", for: .normal)
        confirmButton.setTitleColor(.systemBlue, for: .normal)
        confirmButton.backgroundColor = .clear
        confirmButton.layer.cornerRadius = 4
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        confirmButton.layer.shadowColor = UIColor.black.cgColor
        confirmButton.layer.shadowOpacity = 0.2
        confirmButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        confirmButton.layer.shadowRadius = 4

        // Botão Rascunho
        let draftButton = UIButton(type: .system)
        draftButton.setTitle("Salvar Rascunho", for: .normal)
        draftButton.setTitleColor(.black, for: .normal)
        draftButton.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 239/255, alpha: 1.0)
        draftButton.layer.cornerRadius = 4
        draftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        draftButton.layer.shadowColor = UIColor.black.cgColor
        draftButton.layer.shadowOpacity = 0.2
        draftButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        draftButton.layer.shadowRadius = 4

        // Stack dos botões
        let buttonStackView = UIStackView(arrangedSubviews: [draftButton, confirmButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
        return containerView
    }()

    private lazy var stackView: UIStackView = createStackView(
        subViews: [
            titleLabel,
            nameEventTextField,
            descriptionEventTextView,
            dateTextField,
            locationTextField,
            categoryTextField,
            publicOrPrivateTextField,
            participantsView,
            actionButtonsView,
        ],
        spacing: 16
    )
    
//MARK: - Factory
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrain()
        setupCalendarConstrain()
        dateTextField.delegate = self
        descriptionEventTextView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Função para gerar a stack
    private func createStackView(subViews: [UIView], spacing: CGFloat = 8) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.alignment = .fill
        return stackView
    }
    
    //Função Icon+ Label
    func makeIconLabelView(iconName: String, labelText: String) -> UIView {
        let icon = UIImageView(image: UIImage(systemName: iconName))
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.contentMode = .scaleAspectFit
            icon.tintColor = .black
            icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 20).isActive = true

            let label = UILabel()
            label.text = labelText
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 16)

            let stackView = UIStackView(arrangedSubviews: [icon, label])
            stackView.axis = .horizontal
            stackView.spacing = 6
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false

            let container = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))
            container.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
                stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])

            return container
    }
    
    //Função Ícone de seta
    func makeArrowIconView() -> UIView {
        let arrowContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 42))
        
        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = .gray
        
        arrowContainerView.addSubview(arrowIcon)
        NSLayoutConstraint.activate([
            arrowIcon.trailingAnchor.constraint(equalTo: arrowContainerView.trailingAnchor, constant: -16),
            arrowIcon.centerYAnchor.constraint(equalTo: arrowContainerView.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 18),
            arrowIcon.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        return arrowContainerView
    }
    
    //FUNÇÕES DO CALENDÁRIO
    // Função para mostrar o calendário
    @objc private func showCalendar() {
        calendarContainerView.isHidden = false
        self.bringSubviewToFront(calendarContainerView)
    }
    // Função para fechar o calendário
    @objc private func doneButtonTapped() {
        self.endEditing(true)
        calendarContainerView.isHidden = true
    }
    // Método chamado quando uma data é selecionada
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: date)
    }
    
    //Setup delegates
    func configureCalendarDelegates(delegate: FSCalendarDelegate, dataSource: FSCalendarDataSource) {
        calendar.delegate = delegate
        calendar.dataSource = dataSource
    }
}

//MARK: - Constrains
extension CreateEventView {
    func setupConstrain() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        //Placeholder da descrição
        descriptionEventTextView.addSubview(descriptionPlaceholderLabel)
        NSLayoutConstraint.activate([
            descriptionPlaceholderLabel.topAnchor.constraint(equalTo: descriptionEventTextView.topAnchor, constant: 8),
            descriptionPlaceholderLabel.leadingAnchor.constraint(equalTo: descriptionEventTextView.leadingAnchor, constant: 10)
        ])
    }
    
    func setupCalendarConstrain() {
        addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendar)
        calendarContainerView.addSubview(timePicker)
        calendarContainerView.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            calendarContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            calendarContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            calendarContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),

            calendar.topAnchor.constraint(equalTo: calendarContainerView.topAnchor, constant: 16),
            calendar.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor, constant: 16),
            calendar.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor, constant: -16),
            calendar.heightAnchor.constraint(equalToConstant: 300),

            timePicker.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 16),
            timePicker.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor, constant: -16),

            confirmButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 16),
            confirmButton.centerXAnchor.constraint(equalTo: calendarContainerView.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor, constant: -16),
            confirmButton.widthAnchor.constraint(equalToConstant: 200),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension CreateEventView: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTextField {
            showCalendar()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
            descriptionPlaceholderLabel.isHidden = !textView.text.isEmpty
    }

}

//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})
