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
        textView.text = "Descrição"
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 5
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        textView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        return textView
    }()
    
    //Data e Hora <--
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true

        //Left View (Ícone + Label)
        let iconSize: CGFloat = 20
        let labelWidth: CGFloat = 100
        let height: CGFloat = 42

        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + labelWidth + 12, height: height))

        let calendarIcon = UIImageView(image: UIImage(systemName: "calendar"))
        calendarIcon.contentMode = .scaleAspectFit
        calendarIcon.tintColor = .black
        calendarIcon.frame = CGRect(x: 8, y: (height - iconSize)/2, width: iconSize, height: iconSize)

        let label = UILabel(frame: CGRect(x: calendarIcon.frame.maxX + 6, y: 0, width: labelWidth, height: height))
        label.text = "Data e Hora"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        leftContainerView.addSubview(calendarIcon)
        leftContainerView.addSubview(label)
        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Ícone seta à direita
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

        textField.rightView = arrowContainerView
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

        // Container para ícone e label
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

        // Ícone
        let locationIcon = UIImageView(image: UIImage(systemName: "pin"))
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.contentMode = .scaleAspectFit
        locationIcon.tintColor = .black

        // Label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Localização"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        // StackView
        let leftStackView = UIStackView(arrangedSubviews: [locationIcon, label])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        leftStackView.alignment = .center

        leftContainerView.addSubview(leftStackView)

        // Constraints internas do leftStackView dentro do leftContainerView
        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 8),
            leftStackView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
            leftStackView.centerYAnchor.constraint(equalTo: leftContainerView.centerYAnchor),

            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            locationIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Ícone seta à direita
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

        textField.rightView = arrowContainerView
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
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

        // Ícone da categoria
        let categoryIcon = UIImageView(image: UIImage(systemName: "face.smiling"))
        categoryIcon.translatesAutoresizingMaskIntoConstraints = false
        categoryIcon.contentMode = .scaleAspectFit
        categoryIcon.tintColor = .black

        // Label "Categoria"
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Categoria"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        // StackView para ícone + label
        let leftStackView = UIStackView(arrangedSubviews: [categoryIcon, label])
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        leftStackView.alignment = .center

        leftContainerView.addSubview(leftStackView)

        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 8),
            leftStackView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor),
            leftStackView.centerYAnchor.constraint(equalTo: leftContainerView.centerYAnchor),

            categoryIcon.widthAnchor.constraint(equalToConstant: 20),
            categoryIcon.heightAnchor.constraint(equalToConstant: 20)
        ])

        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Ícone seta à direita
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

        textField.rightView = arrowContainerView
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

        // Container esquerdo com ícone e label
        let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 42))

        let icon = UIImageView(image: UIImage(systemName: "lock"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Evento Privado"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)

        let stackView = UIStackView(arrangedSubviews: [icon, label])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.frame = leftContainerView.bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        leftContainerView.addSubview(stackView)
        textField.leftView = leftContainerView
        textField.leftViewMode = .always

        // Container direito com UISwitch
        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = .systemBlue

        let switchContainer = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 42))
        switchView.center = switchContainer.center
        switchContainer.addSubview(switchView)

        textField.rightView = switchContainer
        textField.rightViewMode = .always

        return textField
    }()
    
    private let publicOrPrivateContainerView: UIView = {
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
        participantsStackView.alignment = .center
        participantsStackView.translatesAutoresizingMaskIntoConstraints = false

        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.layer.cornerRadius = 16
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray
            imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
            participantsStackView.addArrangedSubview(imageView)
        }

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
    }
}

//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventViewController()
})
