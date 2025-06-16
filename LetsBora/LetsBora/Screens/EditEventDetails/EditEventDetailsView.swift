//
//  EditEventDetailsView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/05/25.
//

import UIKit

protocol EditEventViewDelegate: AnyObject {
    func didTapSave() 
    func didTapCancel()
}

class EditEventDetailsView: UIView {
    weak var delegate: EditEventViewDelegate?
    
    // Date Formatter para exibir e parsear datas
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm" // Ajuste o formato conforme necessário
        return formatter
    }()
    
    // --- UI Components ---
    lazy private var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    lazy private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // --- Date ---
    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Data e Hora"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels // Ou .inline, .compact
        }
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        textField.inputView = datePicker
        
        // Toolbar para o DatePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(datePickerDoneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        return textField
    }()
    lazy var dateErrorLabel = makeErrorLabel()
    
    // Variável para guardar a data selecionada no picker
    private(set) var selectedDate: Date?
    
    // --- Location & Address ---
    lazy var locationTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Local"
        textView.borderStyle = .roundedRect
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    lazy var locationErrorLabel = makeErrorLabel()
    
    lazy var addressTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Endereço"
        textView.borderStyle = .roundedRect
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    lazy var addressErrorLabel = makeErrorLabel()
    
    // --- Description ---
    lazy var descriptionTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Descrição"
        textfield.contentVerticalAlignment = .top
        return textfield
    }()
    lazy var descriptionErrorLabel = makeErrorLabel()
    
    // --- Cost ---
    lazy var costTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Custo"
        textView.borderStyle = .roundedRect
        textView.keyboardType = .decimalPad
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    lazy var costErrorLabel = makeErrorLabel()
    
    // --- Buttons ---
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // --- Actions for DatePicker ---
    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
        
    @objc private func datePickerDoneTapped() {
        if selectedDate == nil, let picker = dateTextField.inputView as? UIDatePicker {
            // Se o usuário não mexeu no picker, mas clicou em OK, pega a data atual do picker
            selectedDate = picker.date
            dateTextField.text = dateFormatter.string(from: picker.date)
        }
        dateTextField.resignFirstResponder()
    }
    
    // --- Public methods to populate fields ---
    func configure(with event: Event) {
        self.selectedDate = event.date
        dateTextField.text = dateFormatter.string(from: event.date)
        
        if let datePicker = dateTextField.inputView as? UIDatePicker {
            datePicker.setDate(event.date, animated: false)
        }
        
        locationTextField.text = event.locationDetails?.name
        addressTextField.text = event.locationDetails?.address
        descriptionTextField.text = event.description
        costTextField.text = event.totalCost
    }
    
    // --- Error Label Factory ---
    private func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }
    
    // --- Delegate methods ---
    @objc private func didTapSave() { delegate?.didTapSave() }
    @objc private func didTapCancel() { delegate?.didTapCancel() }
    
    // --- Error Display Methods ---
    func displayDateError(_ message: String?) {
        dateErrorLabel.text = message
        dateErrorLabel.isHidden = (message == nil)
        // Adicionar feedback visual (borda) se desejar
    }
    func displayLocationError(_ message: String?) {
        locationErrorLabel.text = message
        locationErrorLabel.isHidden = (message == nil)
    }
    func displayAddressError(_ message: String?) {
        addressErrorLabel.text = message
        addressErrorLabel.isHidden = (message == nil)
    }
    func displayDescriptionError(_ message: String?) {
        descriptionErrorLabel.text = message
        descriptionErrorLabel.isHidden = (message == nil)
    }
    func displayCostError(_ message: String?) {
        costErrorLabel.text = message
        costErrorLabel.isHidden = (message == nil)
    }
        
    func resetAllErrorVisuals() {
        displayDateError(nil)
        displayLocationError(nil)
        displayAddressError(nil)
        displayDescriptionError(nil)
        displayCostError(nil)
        // Resetar bordas dos textfields se aplicável
    }
}

extension EditEventDetailsView: ViewCode{
    func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(dateTextField)
        contentView.addSubview(dateErrorLabel)
        contentView.addSubview(locationTextField)
        contentView.addSubview(locationErrorLabel)
        contentView.addSubview(addressTextField)
        contentView.addSubview(addressErrorLabel)
        contentView.addSubview(descriptionTextField)
        contentView.addSubview(descriptionErrorLabel)
        contentView.addSubview(costTextField)
        contentView.addSubview(costErrorLabel)
        contentView.addSubview(saveButton)
        contentView.addSubview(cancelButton)
    }
    
    func setConstraints() {
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
            
            // Date
            dateTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            dateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            dateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            dateTextField.heightAnchor.constraint(equalToConstant: 44),
            dateErrorLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 4),
            dateErrorLabel.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            dateErrorLabel.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            
            // Location
            locationTextField.topAnchor.constraint(equalTo: dateErrorLabel.bottomAnchor, constant: 16),
            locationTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            locationTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            locationTextField.heightAnchor.constraint(equalToConstant: 44),
            locationErrorLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 4),
            locationErrorLabel.leadingAnchor.constraint(equalTo: locationTextField.leadingAnchor),
            locationErrorLabel.trailingAnchor.constraint(equalTo: locationTextField.trailingAnchor),
            
            // Address
            addressTextField.topAnchor.constraint(equalTo: locationErrorLabel.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            addressTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            addressTextField.heightAnchor.constraint(equalToConstant: 44),
            addressErrorLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 4),
            addressErrorLabel.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor),
            addressErrorLabel.trailingAnchor.constraint(equalTo: addressTextField.trailingAnchor),
            
            // Description
            descriptionTextField.topAnchor.constraint(equalTo: addressErrorLabel.bottomAnchor, constant: 16),
            descriptionTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 88),
            descriptionErrorLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 4),
            descriptionErrorLabel.leadingAnchor.constraint(equalTo: descriptionTextField.leadingAnchor),
            descriptionErrorLabel.trailingAnchor.constraint(equalTo: descriptionTextField.trailingAnchor),
            
            // Cost
            costTextField.topAnchor.constraint(equalTo: descriptionErrorLabel.bottomAnchor, constant: 16),
            costTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            costTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            costTextField.heightAnchor.constraint(equalToConstant: 44),
            costErrorLabel.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 4),
            costErrorLabel.leadingAnchor.constraint(equalTo: costTextField.leadingAnchor),
            costErrorLabel.trailingAnchor.constraint(equalTo: costTextField.trailingAnchor),
            
            // Buttons
            saveButton.topAnchor.constraint(equalTo: costErrorLabel.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
