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
    
    private lazy var navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Detalhes Aniversário do Pedro"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "event-sample-image")
        return imageView
    }()
    
    private lazy var tabStackView: UIStackView = {
        return createTabStackView()
    }()
    
    private lazy var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "29 de março | 19:00 - 21:00"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Casa do Jorge"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        let addressLabel = UILabel()
        addressLabel.text = "Rua das Flores, 123"
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(addressLabel)
        
        return stack
    }()
    
    private lazy var participantsLabel: UILabel = {
        let label = UILabel()
        label.text = "Participantes (25)"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var participantsBadge: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "+22"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4)
        ])
        
        return view
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
        addSubview(navigationBar)
        addSubview(eventImageView)
        addSubview(tabStackView)
        addSubview(dateTimeLabel)
        addSubview(locationStack)
        addSubview(participantsLabel)
        addSubview(participantsBadge)
        addSubview(descriptionLabel)
        addSubview(descriptionText)
        addSubview(costLabel)
        addSubview(perPersonLabel)
        addSubview(priceLabel)
        addSubview(confirmButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            eventImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            tabStackView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor),
            tabStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tabStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tabStackView.heightAnchor.constraint(equalToConstant: 40),
            
            dateTimeLabel.topAnchor.constraint(equalTo: tabStackView.bottomAnchor, constant: 16),
            dateTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            locationStack.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 16),
            locationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            participantsLabel.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 16),
            participantsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            participantsBadge.centerYAnchor.constraint(equalTo: participantsLabel.centerYAnchor),
            participantsBadge.leadingAnchor.constraint(equalTo: participantsLabel.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: participantsLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            costLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 24),
            costLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            costLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            perPersonLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 8),
            perPersonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            priceLabel.centerYAnchor.constraint(equalTo: perPersonLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createTabStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let tabs = ["Chat", "Custos", "Mapa", "Alertas"]
        tabs.forEach { tabName in
            let button = UIButton()
            button.setTitle(tabName, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
}
