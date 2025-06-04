//
//  CreateEventView.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 03/04/25.
//

import UIKit

protocol CreateEventViewDelegate: AnyObject {
    func didConfirmDateTime(date: Date, time: Date)
    func publishEventTapped()
    func saveDraftTapped()
    func didTapLocationContainer()
    func didSelectCategory(_ category: String)
    func didTapInviteButton()
}

class CreateEventView: UIView {
    // MARK: -  Variables
    private weak var delegate: CreateEventViewDelegate?
    
    func delegate(inject: CreateEventViewDelegate){
        self.delegate =  inject
    }
    public var selectedDateAndTime: Date? // Para armazenar a data/hora combinada
    private var selectedCategory: String?
    var categories: [String] = []
    
    
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
    
    // --- Nome do Evento ---
    lazy var nameEventTextField: ReusableTextField = {
       let reusabelTextField = ReusableTextField(
        placeholder: "Nome do Evento")
        return reusabelTextField
    }()
    // used in validation
    lazy var nameEventErrorLabel: ReusableLabel = {
        let reusableLabel = ReusableLabel(
            preset: .errorLabel
        )
        return reusableLabel
    }()
    
    // --- Descrição ---
    let descriptionEventTextView : ReusableTextView = {
       let reusableTextView = ReusableTextView(
            placeholder: "Adicione uma descrição para o seu evento"
       )
        return reusableTextView
    }()
    
    lazy var descriptionErrorLabel: ReusableLabel = { // Label de erro para descrição
        let reusableLabel = ReusableLabel(
            preset: .errorLabel
        )
        return reusableLabel
    }()
    
    // --- Data e Hora ---
    lazy var dateCustomContainer: CustomContainer = {
        let container = CustomContainer(
            iconName: "calendar",
            labelName: "Data e Hora",
            arrowName: "chevron.right",
            type: .date
        )
        return container
    }()
    
    lazy var dateTimeErrorLabel: UILabel = {
        let reusableLabel = ReusableLabel(
            preset: .errorLabel
        )
        return reusableLabel
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
        picker.minimumDate = Date()
        return picker
    }()
    
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private lazy var dateTimeConfirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.addTarget(self, action: #selector(confirmDateTimeTapped), for: .touchUpInside)
        return button
    }()
    
    // --- Localização ---
    lazy var locationCustomContainer: CustomContainer = {
        let container = CustomContainer(iconName: "pin", labelName: "Localização", arrowName: "chevron.right", type: .location)
        return container
    }()
    
    lazy var locationErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    // --- Categoria ---
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        return textField
    }()
    
    private lazy var categoryPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var categoryCustomContainer: CustomContainer = {
        let container = CustomContainer(
            iconName: "smiley",
            labelName: "Categoria",
            arrowName: "chevron.right",
            type: .category
        )
        return container
    }()
    
    let switchView = UISwitch()
    
    lazy var categoryErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    
    // --- Público ou Privado ---
    lazy var eventPrivacySwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = false
        switchView.onTintColor = .systemBlue
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()
    
    private lazy var publicOrPrivateContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return containerView
    }()
    private lazy var leftView : UIView = {
        let leftView = makeIconLabelView(iconName: "lock", labelText: "Evento Privado")
        leftView.translatesAutoresizingMaskIntoConstraints = false
        return leftView
    }()
    
    // --- Convidar participantes ---
    // Label + Ícone (top left)
    private lazy var iconLabelView: UIView = {
        let iconLabelView = makeIconLabelView(iconName: "person", labelText: "Participantes")
        iconLabelView.translatesAutoresizingMaskIntoConstraints = false
        return iconLabelView
    }()
    // Botão "Convidar" (bottom right)
    private lazy var inviteButton: UIView = {
        let button = UIButton(type: .system)
        button.setTitle("Convidar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addTarget(self, action: #selector(handleInviteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func handleInviteButtonTapped(){
        self.delegate?.didTapInviteButton()
    }
    
    // Stack de imagens dos participantes (bottom left)
    private lazy var avatarsGroupView: AvatarGroupView = {
        let avatarGroupView = AvatarGroupView()
        avatarGroupView.setAvatars([])
        return avatarGroupView
    }()
    
    func setAvatars(_ avatars: [String]){
        self.avatarsGroupView.setAvatars(avatars)
        if(avatars.count > 3) {
            self.avatarsGroupView.setExtraCount(avatars.count - 3)
        }
    }
    
    private lazy var participantsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return containerView
    }()
    
    // --- Botões ---
    lazy var publishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Publicar Evento", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(publishButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var draftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salvar Rascunho", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 239/255, alpha: 1.0)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(draftButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionButtonsContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        
        let buttonStackView = UIStackView(arrangedSubviews: [draftButton, publishButton])
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
        setupConstraints()
        setupCategoryPicker()
        setupCalendarConstraints()
        dateCustomContainer.delegate = self
        locationCustomContainer.delegate = self
        categoryCustomContainer.delegate = self
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(scrollView)
        
        addSubview(categoryTextField)
        addSubview(calendarContainerView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(nameEventTextField)
        contentView.addSubview(nameEventErrorLabel)

        contentView.addSubview(descriptionEventTextView)
        contentView.addSubview(descriptionErrorLabel)
        
        contentView.addSubview(dateCustomContainer)
        contentView.addSubview(dateTimeErrorLabel)
        
        contentView.addSubview(locationCustomContainer)
        contentView.addSubview(locationErrorLabel)
        
        contentView.addSubview(categoryCustomContainer)
        contentView.addSubview(categoryErrorLabel)
        
        contentView.addSubview(publicOrPrivateContainerView)
        
        contentView.addSubview(participantsView)
        
        contentView.addSubview(actionButtonsContainerView)
        
        
        calendarContainerView.addSubview(calendar)
        calendarContainerView.addSubview(timePicker)
        calendarContainerView.addSubview(dateTimeConfirmButton)
        
        publicOrPrivateContainerView.addSubview(leftView)
        publicOrPrivateContainerView.addSubview(eventPrivacySwitch)
        
        participantsView.addSubview(iconLabelView)
        participantsView.addSubview(inviteButton)
        participantsView.addSubview(avatarsGroupView)
        
    }
    
    // MARK: Factory
    // Função TextField
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
    @objc private func confirmDateTimeTapped() {
        self.endEditing(true)
        
        // Combina data do calendário com hora do timePicker
        let calendarDate = calendar.date
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)
        
        if let hour = timeComponents.hour, let minute = timeComponents.minute {
            if let combinedDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: calendarDate) {
                self.selectedDateAndTime = combinedDate
                
                // Formata a data e hora para mostrar no `dateCustomContainer`
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
                dateCustomContainer.updateLabelName(newName: dateFormatter.string(from: combinedDate))
                
                // Notifica o delegate (ViewController)
                delegate?.didConfirmDateTime(date: calendarDate, time: timePicker.date)
            }
        }
        calendarContainerView.isHidden = true
    }
    
    // Funções para os botões de ação notificarem o delegate
    @objc private func publishButtonAction() {
        delegate?.publishEventTapped()
    }
    
    @objc private func draftButtonAction() {
        delegate?.saveDraftTapped()
    }
    
    // Limpa todos os erros visuais
    func resetAllErrorVisuals() {
        nameEventErrorLabel.isHidden = true
        nameEventTextField.layer.borderColor = UIColor.clear.cgColor
        nameEventTextField.layer.borderWidth = 0
        
        descriptionErrorLabel.isHidden = true
        descriptionEventTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionEventTextView.layer.borderWidth = 0.5
        
        dateTimeErrorLabel.isHidden = true
        // Adicione feedback visual para dateCustomContainer se desejar (ex: borda)
        // dateCustomContainer.layer.borderColor = ...
        
        locationErrorLabel.isHidden = true
        // locationCustomContainer.layer.borderColor = ...
        
        categoryErrorLabel.isHidden = true
        // categoryCustomContainer.layer.borderColor = ...
    }
    
}

extension CreateEventView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Apenas uma coluna para categorias
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !categories.isEmpty && row < categories.count {
            selectedCategory = categories[row]
            // Opcional: Atualizar o label do container imediatamente ao selecionar,
            // mas geralmente se faz isso ao clicar em "OK" na toolbar.
            categoryCustomContainer.updateLabelName(newName: selectedCategory ?? "Categoria")
        }
    }
    
    @objc private func categoryPickerDoneTapped() {
        if let category = selectedCategory {
            categoryCustomContainer.updateLabelName(newName: category)
            delegate?.didSelectCategory(category) // Notifica o ViewController
        } else if !categories.isEmpty {
            // Se nada foi explicitamente selecionado, mas há categorias,
            // seleciona a primeira e notifica.
            let firstCategory = categories[0]
            selectedCategory = firstCategory
            categoryPickerView.selectRow(0, inComponent: 0, animated: false) // Atualiza o picker visualmente
            categoryCustomContainer.updateLabelName(newName: firstCategory)
            delegate?.didSelectCategory(firstCategory)
        }
        categoryTextField.resignFirstResponder() // Dispensa o picker
    }
}

extension CreateEventView: CustomContainerDelegate {
    func containerTapped(type: ContainerType) {
        if type == .date {
            calendarContainerView.isHidden = false
            self.bringSubviewToFront(calendarContainerView)
        } else if type == .location {
            delegate?.didTapLocationContainer()
        } else if type == .category {
            categoryTextField.becomeFirstResponder()
        }
    }
}

//MARK: - Constraints
extension CreateEventView {
    func setupConstraints() {
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
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20), // Reduzido o top para caber mais na tela
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Nome do Evento + Erro
            nameEventTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            nameEventTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameEventTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            // nameEventTextField.heightAnchor já definido na criação do componente
            
            nameEventErrorLabel.topAnchor.constraint(equalTo: nameEventTextField.bottomAnchor, constant: 4),
            nameEventErrorLabel.leadingAnchor.constraint(equalTo: nameEventTextField.leadingAnchor),
            nameEventErrorLabel.trailingAnchor.constraint(equalTo: nameEventTextField.trailingAnchor),
            
            // Descrição + Erro
            descriptionEventTextView.topAnchor.constraint(equalTo: nameEventErrorLabel.bottomAnchor, constant: 16), // Ajustado para vir após o erro
            descriptionEventTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionEventTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            // descriptionEventTextView.heightAnchor já definido
            
            descriptionErrorLabel.topAnchor.constraint(equalTo: descriptionEventTextView.bottomAnchor, constant: 4),
            descriptionErrorLabel.leadingAnchor.constraint(equalTo: descriptionEventTextView.leadingAnchor),
            descriptionErrorLabel.trailingAnchor.constraint(equalTo: descriptionEventTextView.trailingAnchor),
            
            // Data e Hora + Erro
            dateCustomContainer.topAnchor.constraint(equalTo: descriptionErrorLabel.bottomAnchor, constant: 16),
            dateCustomContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateCustomContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateCustomContainer.heightAnchor.constraint(equalToConstant: 48),
            
            dateTimeErrorLabel.topAnchor.constraint(equalTo: dateCustomContainer.bottomAnchor, constant: 4),
            dateTimeErrorLabel.leadingAnchor.constraint(equalTo: dateCustomContainer.leadingAnchor),
            dateTimeErrorLabel.trailingAnchor.constraint(equalTo: dateCustomContainer.trailingAnchor),
            
            // Localização + Erro
            locationCustomContainer.topAnchor.constraint(equalTo: dateTimeErrorLabel.bottomAnchor, constant: 16),
            locationCustomContainer.heightAnchor.constraint(equalToConstant: 48),
            locationCustomContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationCustomContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            locationErrorLabel.topAnchor.constraint(equalTo: locationCustomContainer.bottomAnchor, constant: 4),
            locationErrorLabel.leadingAnchor.constraint(equalTo: locationCustomContainer.leadingAnchor),
            locationErrorLabel.trailingAnchor.constraint(equalTo: locationCustomContainer.trailingAnchor),
            
            // Categoria + Erro
            categoryCustomContainer.topAnchor.constraint(equalTo: locationErrorLabel.bottomAnchor, constant: 16),
            categoryCustomContainer.heightAnchor.constraint(equalToConstant: 48),
            categoryCustomContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryCustomContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            categoryErrorLabel.topAnchor.constraint(equalTo: categoryCustomContainer.bottomAnchor, constant: 4),
            categoryErrorLabel.leadingAnchor.constraint(equalTo: categoryCustomContainer.leadingAnchor),
            categoryErrorLabel.trailingAnchor.constraint(equalTo: categoryCustomContainer.trailingAnchor),
            
            // Privacidade
            publicOrPrivateContainerView.topAnchor.constraint(equalTo: categoryErrorLabel.bottomAnchor, constant: 16), // publicOrPrivateTextField renomeado
            publicOrPrivateContainerView.heightAnchor.constraint(equalToConstant: 48),
            publicOrPrivateContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            publicOrPrivateContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            leftView.leadingAnchor.constraint(equalTo: publicOrPrivateContainerView.leadingAnchor, constant: 8),
            leftView.centerYAnchor.constraint(equalTo: publicOrPrivateContainerView.centerYAnchor),
            eventPrivacySwitch.trailingAnchor.constraint(equalTo: publicOrPrivateContainerView.trailingAnchor, constant: -16),
            eventPrivacySwitch.centerYAnchor.constraint(equalTo: publicOrPrivateContainerView.centerYAnchor),
            
            // Participantes
            participantsView.topAnchor.constraint(equalTo: publicOrPrivateContainerView.bottomAnchor, constant: 24),
            participantsView.heightAnchor.constraint(equalToConstant: 80),
            participantsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            participantsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            iconLabelView.topAnchor.constraint(equalTo: participantsView.topAnchor, constant: 10),
            iconLabelView.leadingAnchor.constraint(equalTo: participantsView.leadingAnchor, constant: 12),
            avatarsGroupView.leadingAnchor.constraint(equalTo: participantsView.leadingAnchor, constant: 12),
            avatarsGroupView.bottomAnchor.constraint(equalTo: participantsView.bottomAnchor, constant: -10),
            inviteButton.trailingAnchor.constraint(equalTo: participantsView.trailingAnchor, constant: -12),
            inviteButton.bottomAnchor.constraint(equalTo: participantsView.bottomAnchor, constant: -12),
            
            
            // Botões de Ação
            actionButtonsContainerView.topAnchor.constraint(equalTo: participantsView.bottomAnchor, constant: 32),
            actionButtonsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionButtonsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionButtonsContainerView.heightAnchor.constraint(equalToConstant: 50),
            actionButtonsContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32) // Garante que o scrollview tenha conteúdo suficiente
        ])
    }
    
    private func setupCategoryPicker() {
        // Configura o inputView e inputAccessoryView para o categoryTextField
        categoryTextField.inputView = categoryPickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(categoryPickerDoneTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        categoryTextField.inputAccessoryView = toolbar
        
        // Adicionar o categoryTextField à hierarquia para que possa se tornar first responder
        // Mesmo que oculto, ele precisa estar na view.
        addSubview(categoryTextField)
    }
    
    func setupCalendarConstraints() { // Renomeado
        NSLayoutConstraint.activate([
            calendarContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            calendarContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            calendarContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            // Ajustar altura do container do calendário para caber os componentes
            // calendarContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7), // Pode ser muito grande
            // Vamos definir uma altura baseada nos seus componentes internos
            
            calendar.topAnchor.constraint(equalTo: calendarContainerView.topAnchor, constant: 8),
            calendar.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor, constant: 16),
            calendar.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor, constant: -16),
            calendar.heightAnchor.constraint(equalToConstant: 300), // Como definido antes
            
            timePicker.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 8),
            timePicker.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor, constant: -16),
            // Altura do timePicker é intrínseca para .wheels, mas pode-se adicionar uma constraint se necessário.
            // timePicker.heightAnchor.constraint(equalToConstant: 150), // Exemplo
            
            dateTimeConfirmButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 16), // Aumentar espaçamento
            dateTimeConfirmButton.centerXAnchor.constraint(equalTo: calendarContainerView.centerXAnchor),
            dateTimeConfirmButton.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor, constant: -16),
            dateTimeConfirmButton.widthAnchor.constraint(equalToConstant: 160),
            // dateTimeConfirmButton.heightAnchor já definido na criação
        ])
    }
}
