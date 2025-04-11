//
//  EventDetailsView.swift
//  LetsBora
//
//  Created by Joel Lacerda on 11/04/25.
//

import Foundation
import UIKit

class EventDetailsView: UIView {
    // MARK: - UI Components
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tabStackView: UIStackView = {
        return createTabStackView()
    }()
    
    private lazy var dateContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var participantsLabel: UILabel = {
        let label = UILabel()
        label.text = "Participantes (25)"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.text = "Venha celebrar meu aniversário! Teremos música ao vivo, comida boa e muita diversão. Traga um presente e um sorriso!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.text = "Custos do Evento"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var perPersonLabel: UILabel = {
        let label = UILabel()
        label.text = "Por pessoa"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "R$20,00"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirmar Presença", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubview(eventImageView)
        addSubview(tabStackView)
        addSubview(dateContainer)
        addSubview(locationContainer)
        addSubview(participantsLabel)
        addSubview(descriptionLabel)
        addSubview(descriptionText)
        addSubview(costLabel)
        addSubview(perPersonLabel)
        addSubview(priceLabel)
        addSubview(confirmButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: topAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventImageView.heightAnchor.constraint(equalToConstant: 245),
            
            tabStackView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor),
            tabStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabStackView.heightAnchor.constraint(equalToConstant: 60),
            
            dateContainer.topAnchor.constraint(equalTo: tabStackView.bottomAnchor, constant: 10),
            dateContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateContainer.heightAnchor.constraint(equalToConstant: 50),
            
            locationContainer.topAnchor.constraint(equalTo: dateContainer.bottomAnchor, constant: 10),
            locationContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationContainer.heightAnchor.constraint(equalToConstant: 50),
            
            participantsLabel.topAnchor.constraint(equalTo: locationContainer.bottomAnchor, constant: 10),
            participantsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            participantsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            participantsLabel.heightAnchor.constraint(equalToConstant: 70),
            
            descriptionLabel.topAnchor.constraint(equalTo: participantsLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            costLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 10),
            costLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            perPersonLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 10),
            perPersonLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            confirmButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createTabStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let tabs = ["Chat", "Custos", "Mapa", "Notificações"]
        tabs.forEach { tabName in
            let button = UIButton()
            button.setTitle(tabName, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
}
