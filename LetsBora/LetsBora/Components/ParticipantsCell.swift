//
//  ParticipantsCell.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 29/05/25.
//

import UIKit

class ParticipantCell: UITableViewCell {
    
    static let identifier = "ParticipantCell"
    
    private let imageSize: CGFloat = 40
    private let fontSize: CGFloat = 16

    // MARK: Components
    private lazy var containerParticipant: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var imageParticipant: UIImageView = {
        let image = UIImageView(image: .julia)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var titleParticipant: UILabel = {
        let label = UILabel()
        label.text = "Ana Clara"
        label.textColor = .black
        label.font = .systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusPayment: UILabel = {
        let label = UILabel()
        label.text = "Pago"
        label.textColor = .systemGreen // Default
        label.font = .systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var valueParticipant: UILabel = {
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

    // MARK: Config
    func configure(name: String, imageName: String) {
        titleParticipant.text = name
        //statusPayment.text = status ? "Pago" : "Pendente"
        //statusPayment.textColor = status ? .systemGreen : .red
        //valueParticipant.text = value
        imageParticipant.image = UIImage(named: imageName)
    }


    private func setupView() {
        contentView.addSubview(containerParticipant)
        containerParticipant.addSubview(imageParticipant)
        containerParticipant.addSubview(titleParticipant)
        containerParticipant.addSubview(statusPayment)
        containerParticipant.addSubview(valueParticipant)

        NSLayoutConstraint.activate([
            containerParticipant.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerParticipant.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerParticipant.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerParticipant.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerParticipant.heightAnchor.constraint(equalToConstant: 60),

            imageParticipant.leadingAnchor.constraint(equalTo: containerParticipant.leadingAnchor, constant: 10),
            imageParticipant.centerYAnchor.constraint(equalTo: containerParticipant.centerYAnchor),
            imageParticipant.widthAnchor.constraint(equalToConstant: imageSize),
            imageParticipant.heightAnchor.constraint(equalToConstant: imageSize),

            titleParticipant.topAnchor.constraint(equalTo: containerParticipant.topAnchor, constant: 10),
            titleParticipant.leadingAnchor.constraint(equalTo: imageParticipant.trailingAnchor, constant: 10),

            statusPayment.bottomAnchor.constraint(equalTo: containerParticipant.bottomAnchor, constant: -10),
            statusPayment.leadingAnchor.constraint(equalTo: imageParticipant.trailingAnchor, constant: 10),

            valueParticipant.centerYAnchor.constraint(equalTo: containerParticipant.centerYAnchor),
            valueParticipant.trailingAnchor.constraint(equalTo: containerParticipant.trailingAnchor, constant: -10)
        ])
    }
}

