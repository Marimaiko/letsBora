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
        
        let backButton: UIButton = {
            let btn = UIButton()
            btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            btn.tintColor = .systemBlue
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        let titleLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "Detalhes Aniversário do Pedro"
            lbl.font = .systemFont(ofSize: 17, weight: .semibold)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
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
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let tabs: [(title: String, systemImageName: String)] = [
            ("Chat", "bubble.left"),
            ("Custos", "dollarsign.circle"),
            ("Mapa", "map"),
            ("Alertas", "bell")
        ]
        
        tabs.forEach { tab in
            var config = UIButton.Configuration.plain()
            config.title = tab.title
            config.image = UIImage(systemName: tab.systemImageName)
            config.imagePlacement = .top
            config.imagePadding = 4
            
            let button = UIButton(configuration: config)
            button.tintColor = .systemBlue
            
            stack.addArrangedSubview(button)
        }
        
        return stack
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
    
    private lazy var participantsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let label: UILabel = {
            let lbl = UILabel()
            lbl.text = "Participantes (25)"
            lbl.font = .systemFont(ofSize: 16, weight: .medium)
            return lbl
        }()
        
        let badge: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.layer.cornerRadius = 12
            
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
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(badge)
        
        return stack
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
    
    private lazy var costStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let leftLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "Por pessoa"
            lbl.font = .systemFont(ofSize: 14)
            lbl.textColor = .gray
            return lbl
        }()
        
        let rightLabel: UILabel = {
            let lbl = UILabel()
            lbl.text = "R$20,00"
            lbl.font = .systemFont(ofSize: 14)
            lbl.textColor = .gray
            lbl.textAlignment = .right
            return lbl
        }()
        
        stack.addArrangedSubview(leftLabel)
        stack.addArrangedSubview(rightLabel)
        
        return stack
    }()
    
    private lazy var confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Confirmar Presença", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        addSubview(participantsStack)
        addSubview(descriptionLabel)
        addSubview(descriptionText)
        addSubview(costStack)
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
            
            tabStackView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 12),
            tabStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tabStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tabStackView.heightAnchor.constraint(equalToConstant: 40),
            
            dateTimeLabel.topAnchor.constraint(equalTo: tabStackView.bottomAnchor, constant: 16),
            dateTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            locationStack.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 16),
            locationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            participantsStack.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 16),
            participantsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: participantsStack.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            costStack.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            costStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            costStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
