//
//  NewExpenseViewController.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 01/06/25.
//

import UIKit

class NewExpenseViewController: UIViewController {
    
    var onSave: ((Expense) -> Void)?
    private let titleField = UITextField()
    private let descriptionField = UITextField()
    private let valueField = UITextField()
    private let iconImageView = UIImageView()
    private let saveButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        [titleField, descriptionField, valueField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.borderStyle = .roundedRect
            $0.backgroundColor = UIColor.systemGray6
            view.addSubview($0)
        }
        
        titleField.placeholder = "Nome da despesa"
        descriptionField.placeholder = "Descrição"
        valueField.placeholder = "Valor (ex: R$50,00)"
        valueField.keyboardType = .decimalPad
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(systemName: "tag")
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        view.addSubview(iconImageView)

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Salvar", for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleField.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 24),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            descriptionField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            descriptionField.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            descriptionField.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),

            valueField.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 16),
            valueField.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            valueField.trailingAnchor.constraint(equalTo: titleField.trailingAnchor),

            saveButton.topAnchor.constraint(equalTo: valueField.bottomAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func saveTapped() {
        guard
            let title = titleField.text, !title.isEmpty,
            let description = descriptionField.text, !description.isEmpty,
            let value = valueField.text, !value.isEmpty
        else {
            return
        }
        
        let newExpense = Expense(
            title: title,
            detail: description,
            amount: value,
            image: UIImage(systemName: "tag")
        )
        
        onSave?(newExpense)
        dismiss(animated: true)
    }

}
