//
//  CreateEventView.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 03/04/25.
//

import UIKit

class CreateEventView: UIView {

//MARK: - UIComponents
    private lazy var titleLabel = ReusableLabel(text: "Criar Evento", labelType: .title)
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameEventTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nome do evento"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return textField
    }()

    private lazy var descriptionEventTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .black
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.1
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
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
    private lazy var dateCustomContainer: CustomContainer = {
        let container = CustomContainer(iconName: "calendar", labelName: "Data e Hora", arrowName: "chevron.right", type: .date)
        return container
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

    lazy var calendar: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        return picker
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
    private lazy var locationCustomContainer: CustomContainer = {
        let container = CustomContainer(iconName: "pin", labelName: "Localização", arrowName: "chevron.right", type: .location)
        return container
    }()
    
    //Categoria <--
    private lazy var categoryCustomContainer: CustomContainer = {
        let container = CustomContainer(iconName: "smiley", labelName: "Categoria", arrowName: "chevron.right", type: .category)
        return container
    }()
    
    // Público ou Privado <--
    private lazy var publicOrPrivateTextField: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.heightAnchor.constraint(equalToConstant: 42).isActive = true

        let leftView = makeIconLabelView(iconName: "lock", labelText: "Evento Privado")
        leftView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(leftView)

        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = .systemBlue
        switchView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(switchView)

        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            leftView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            switchView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        return containerView
    }()

    
    //Convidar participantes <-
    private lazy var participantsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)

        // Label + Ícone (top left)
        let iconLabelView = makeIconLabelView(iconName: "person", labelText: "Participantes")
        containerView.addSubview(iconLabelView)

        // Botão "Convidar" (bottom right)
        let inviteButton = UIButton(type: .system)
        inviteButton.setTitle("Convidar", for: .normal)
        inviteButton.setTitleColor(.systemBlue, for: .normal)
        inviteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(inviteButton)

        // Stack de imagens dos participantes (bottom left)
        let participantsStackView = UIStackView()
        participantsStackView.axis = .horizontal
        participantsStackView.spacing = 6
        participantsStackView.alignment = .center
        participantsStackView.translatesAutoresizingMaskIntoConstraints = false

        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            participantsStackView.addArrangedSubview(imageView)
        }

        containerView.addSubview(participantsStackView)

        // Constraints internas
        NSLayoutConstraint.activate([
            iconLabelView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            iconLabelView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),

            participantsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            participantsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),

            inviteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            inviteButton.centerYAnchor.constraint(equalTo: participantsStackView.centerYAnchor)
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
        confirmButton.layer.shadowOpacity = 0.1
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
        draftButton.layer.shadowOpacity = 0.1
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
               buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
               buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
               buttonStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
               buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
           ])

        return containerView
    }()
    
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstrains()
        setupCalendarConstrain()
        dateCustomContainer.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(nameEventTextField)
        contentView.addSubview(descriptionEventTextView)
        contentView.addSubview(descriptionPlaceholderLabel)
        contentView.addSubview(dateCustomContainer)
        contentView.addSubview(locationCustomContainer)
        contentView.addSubview(categoryCustomContainer)
        contentView.addSubview(publicOrPrivateTextField)
        contentView.addSubview(participantsView)
        contentView.addSubview(actionButtonsView)
        
        addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendar)
        calendarContainerView.addSubview(timePicker)
        calendarContainerView.addSubview(confirmButton)
    }
    
    //MARK: -Factory
    //Função TextField
    func makeBaseTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return textField
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
        label.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [icon, label])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    //Função Ícone de seta
    func makeArrowIconView() -> UIView {
        let arrowContainerView = UIView()
        arrowContainerView.translatesAutoresizingMaskIntoConstraints = false

        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = .gray

        arrowContainerView.addSubview(arrowIcon)

        NSLayoutConstraint.activate([
            arrowContainerView.widthAnchor.constraint(equalToConstant: 30),
            arrowContainerView.heightAnchor.constraint(equalToConstant: 42),

            arrowIcon.centerXAnchor.constraint(equalTo: arrowContainerView.centerXAnchor),
            arrowIcon.centerYAnchor.constraint(equalTo: arrowContainerView.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 16),
            arrowIcon.heightAnchor.constraint(equalToConstant: 16)
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
}

extension CreateEventView: CustomContainerDelegate {
    func containerTapped(type: ContainerType) {
        if type == .date{
            calendarContainerView.isHidden = false
            self.bringSubviewToFront(calendarContainerView)
        }else if type == .location{
            
        }else if type == .category{
        }
    }
}

//MARK: - Constrains
extension CreateEventView {
    func setupConstrains() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nameEventTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            nameEventTextField.heightAnchor.constraint(equalToConstant: 48),
            nameEventTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameEventTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionEventTextView.topAnchor.constraint(equalTo: nameEventTextField.bottomAnchor, constant: 16),
            descriptionEventTextView.heightAnchor.constraint(equalToConstant: 80),
            descriptionEventTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionEventTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionPlaceholderLabel.topAnchor.constraint(equalTo: descriptionEventTextView.topAnchor, constant: 8),
            descriptionPlaceholderLabel.leadingAnchor.constraint(equalTo: descriptionEventTextView.leadingAnchor, constant: 10),
            
            dateCustomContainer.topAnchor.constraint(equalTo: descriptionEventTextView.bottomAnchor, constant: 16),
            dateCustomContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateCustomContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateCustomContainer.heightAnchor.constraint(equalToConstant: 48),
            
            locationCustomContainer.topAnchor.constraint(equalTo: dateCustomContainer.bottomAnchor, constant: 16),
            locationCustomContainer.heightAnchor.constraint(equalToConstant: 48),
            locationCustomContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationCustomContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoryCustomContainer.topAnchor.constraint(equalTo: locationCustomContainer.bottomAnchor, constant: 16),
            categoryCustomContainer.heightAnchor.constraint(equalToConstant: 48),
            categoryCustomContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryCustomContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            publicOrPrivateTextField.topAnchor.constraint(equalTo: categoryCustomContainer.bottomAnchor, constant: 16),
            publicOrPrivateTextField.heightAnchor.constraint(equalToConstant: 48),
            publicOrPrivateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            publicOrPrivateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            participantsView.topAnchor.constraint(equalTo: publicOrPrivateTextField.bottomAnchor, constant: 24),
            participantsView.heightAnchor.constraint(equalToConstant: 80),
            participantsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            participantsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            actionButtonsView.topAnchor.constraint(equalTo: participantsView.bottomAnchor, constant: 32),
            actionButtonsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionButtonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionButtonsView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButtonsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    func setupCalendarConstrain() {
        NSLayoutConstraint.activate([
            calendarContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            calendarContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            calendarContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            calendarContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),

            calendar.topAnchor.constraint(equalTo: calendarContainerView.topAnchor, constant: 8),
            calendar.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor, constant: 16),
            calendar.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor, constant: -16),
            calendar.heightAnchor.constraint(equalToConstant: 300),

            timePicker.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 8),
            timePicker.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor, constant: -16),

            confirmButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 8),
            confirmButton.centerXAnchor.constraint(equalTo: calendarContainerView.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor, constant: -16),
            confirmButton.widthAnchor.constraint(equalToConstant: 160),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

