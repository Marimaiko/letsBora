//
//  ExpensesCell.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 29/05/25.
//

import UIKit

class ExpenseCell: UITableViewCell {
    
    static let identifier = "ExpenseCell"
    
    private let imageSize: CGFloat = 40
    private let fontSize: CGFloat = 16

    // MARK: Components
    private lazy var containerExpense: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var imageExpense: UIImageView = {
        let image = UIImageView(image: .add)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var titleExpense: UILabel = {
        let label = UILabel()
        label.text = "Uber"
        label.textColor = .black
        label.font = .systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionExpense: UILabel = {
        let label = UILabel()
        label.text = "Corrida de ida"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var valueExpense: UILabel = {
        let label = UILabel()
        label.text = "R$ 50,00"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Config
    func configure(image: UIImage?, title: String, description: String, value: String) {
        imageExpense.image = image
        titleExpense.text = title
        descriptionExpense.text = description
        valueExpense.text = value
    }

    private func setupView() {
        contentView.addSubview(containerExpense)
        containerExpense.addSubview(imageExpense)
        containerExpense.addSubview(titleExpense)
        containerExpense.addSubview(descriptionExpense)
        containerExpense.addSubview(valueExpense)

        NSLayoutConstraint.activate([
            containerExpense.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerExpense.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerExpense.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerExpense.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerExpense.heightAnchor.constraint(equalToConstant: 60),

            imageExpense.leadingAnchor.constraint(equalTo: containerExpense.leadingAnchor, constant: 10),
            imageExpense.centerYAnchor.constraint(equalTo: containerExpense.centerYAnchor),
            imageExpense.widthAnchor.constraint(equalToConstant: imageSize),
            imageExpense.heightAnchor.constraint(equalToConstant: imageSize),

            titleExpense.topAnchor.constraint(equalTo: containerExpense.topAnchor, constant: 10),
            titleExpense.leadingAnchor.constraint(equalTo: imageExpense.trailingAnchor, constant: 10),

            descriptionExpense.bottomAnchor.constraint(equalTo: containerExpense.bottomAnchor, constant: -10),
            descriptionExpense.leadingAnchor.constraint(equalTo: imageExpense.trailingAnchor, constant: 10),

            valueExpense.centerYAnchor.constraint(equalTo: containerExpense.centerYAnchor),
            valueExpense.trailingAnchor.constraint(equalTo: containerExpense.trailingAnchor, constant: -10)
        ])
    }
}
