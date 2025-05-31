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
    
    lazy var dateTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Data e Hora"
        textView.borderStyle = .roundedRect
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var locationTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Local"
        textView.borderStyle = .roundedRect
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var addressTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Endereço"
        textView.borderStyle = .roundedRect
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var descriptionTextView: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Descrição"
        return textfield
    }()
    
    lazy var costTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "Custo"
        textView.borderStyle = .roundedRect
        textView.keyboardType = .decimalPad
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
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
    
    @objc private func didTapSave() {
        delegate?.didTapSave()
    }
    
    @objc private func didTapCancel() {
        delegate?.didTapCancel()
    }
    
}

extension EditEventDetailsView: ViewCode{
    func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [dateTextField, locationTextField, addressTextField, descriptionTextView, costTextField, saveButton, cancelButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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

            dateTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            dateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            dateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            dateTextField.heightAnchor.constraint(equalToConstant: 44),

            locationTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 16),
            locationTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            locationTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            locationTextField.heightAnchor.constraint(equalToConstant: 44),
            
            addressTextField.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            addressTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            addressTextField.heightAnchor.constraint(equalToConstant: 44),

            descriptionTextView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),

            costTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 16),
            costTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            costTextField.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            costTextField.heightAnchor.constraint(equalToConstant: 44),

            saveButton.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: dateTextField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),

            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
