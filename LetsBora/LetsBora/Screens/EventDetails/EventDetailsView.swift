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
    private lazy var headerSpacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
    
    private lazy var containerHeaderStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            headerSpacerView,
            navigationBar,
            eventImageView,
            tabStackView
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 16
        stack.layer.masksToBounds = true
        return stack
    }()

    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(containerHeaderStackView)

        NSLayoutConstraint.activate([
            
            containerHeaderStackView.topAnchor.constraint(equalTo: view.topAnchor),
            containerHeaderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerHeaderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerHeaderStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }()

    
    private lazy var dateTimeLabel: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .top
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView(image: UIImage(systemName: "calendar.circle"))
        iconImageView.tintColor = .black
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fullText = "29 de março | 19:00 - 21:00"
        let attributedText = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15)
            ]
        )
        
        if let range = fullText.range(of: "29 de março") {
            let nsRange = NSRange(range, in: fullText)
            attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: nsRange)
        }
        
        label.attributedText = attributedText
        
        horizontalStack.addArrangedSubview(iconImageView)
        horizontalStack.addArrangedSubview(label)
        horizontalStack.alignment = .center
        
        return horizontalStack
    }()
    
    private lazy var locationStack: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .top
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        let iconImageView = UIImageView(image: UIImage(systemName: "map.circle"))
        iconImageView.tintColor = .black
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "Casa do Jorge"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)

        let addressLabel = UILabel()
        addressLabel.text = "Rua das Flores, 123"
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray

        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(addressLabel)

        horizontalStack.addArrangedSubview(iconImageView)
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.alignment = .center

        return horizontalStack
    }()

    
    private lazy var participantsStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Título
        let titleLabel = UILabel()
        titleLabel.text = "Participantes (25)"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        // Stack só para os ícones de pessoas (com sobreposição)
        let iconsStack = UIStackView()
        iconsStack.axis = .horizontal
        iconsStack.spacing = -12
        iconsStack.alignment = .center
        iconsStack.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<3 {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "person.circle.fill")
            imageView.tintColor = .systemGray
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 2
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
            iconsStack.addArrangedSubview(imageView)
        }
        
        // Stack horizontal principal para ícones + label "+22"
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Label "+22"
        let moreLabel: UILabel = {
            let label = UILabel()
            label.text = "+22"
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        horizontalStack.addArrangedSubview(iconsStack)
        horizontalStack.addArrangedSubview(moreLabel)

        // Montagem do vertical stack
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(horizontalStack)

        return verticalStack
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
        backgroundColor = .systemGroupedBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubview(headerContainerView)

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
            headerSpacerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            headerContainerView.topAnchor.constraint(equalTo: topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            navigationBar.heightAnchor.constraint(equalToConstant: 20),
//
            eventImageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
//            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            eventImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
//            
//            tabStackView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 12),
//            tabStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            tabStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            tabStackView.heightAnchor.constraint(equalToConstant: 40),
            
            dateTimeLabel.topAnchor.constraint(equalTo: tabStackView.bottomAnchor, constant: 15),
            dateTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            locationStack.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 15),
            locationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            participantsStack.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 25),
            participantsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: participantsStack.bottomAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            costStack.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 15),
            costStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            costStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
