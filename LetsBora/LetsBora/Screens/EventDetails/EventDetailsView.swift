//
//  EventDetailsView.swift
//  LetsBora
//
//  Created by Joel Lacerda on 11/04/25.
//

import Foundation
import UIKit

protocol EventDetailsViewDelegate: AnyObject {
    func barButtonTapped(_ sender: UIButton)
    func editTapped()
}

class EventDetailsView: UIView {
    
    weak var delegate: EventDetailsViewDelegate?
    
    // MARK: - ScrollView e ContentView principal
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0 // Espaçamento entre containerHeader e contentInnerStackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - UI Components
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "event-sample-image")
        return imageView
    }()
    
    enum TabTag: Int {
        case chat
        case costs
        case maps
        case alerts
    }
    
    private lazy var tabStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        // translatesAutoresizingMaskIntoConstraints é tratado pela stack pai
        
        let tabs: [(title: String, systemImageName: String, tag: TabTag)] = [
            ("Chat", "bubble.left", .chat),
            ("Custos", "dollarsign.circle", .costs),
            ("Mapa", "map", .maps),
            ("Alertas", "bell", .alerts)
        ]
        
        tabs.forEach { tabInfo in
            var config = UIButton.Configuration.plain()
            config.title = tabInfo.title
            config.image = UIImage(systemName: tabInfo.systemImageName)
            config.imagePlacement = .top
            config.imagePadding = 4
            let button = UIButton(configuration: config)
            button.tintColor = .systemBlue
            button.tag = tabInfo.tag.rawValue
            button.addTarget(self, action: #selector(barButtonTapped(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
        
        return stack
    }()
    
    private lazy var containerHeaderStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [eventImageView, tabStackView])
        stack.axis = .vertical
        stack.spacing = 12
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 16
        stack.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        stack.layer.masksToBounds = true
        // translatesAutoresizingMaskIntoConstraints é tratado pela stack pai
        return stack
    }()

    
    // Stack para o conteúdo abaixo do header, com padding lateral
    private lazy var contentInnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 16, bottom: 24, right: 16)
        return stackView
    }()

    
    private lazy var dateTimeLabel: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center
        
        let iconImageView = UIImageView(image: UIImage(systemName: "calendar.circle"))
        iconImageView.tintColor = .black
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        let label = UILabel()
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
        
        return horizontalStack
    }()
    
    private lazy var locationStack: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center

        let iconImageView = UIImageView(image: UIImage(systemName: "map.circle"))
        iconImageView.tintColor = .black
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
             iconImageView.widthAnchor.constraint(equalToConstant: 32),
             iconImageView.heightAnchor.constraint(equalToConstant: 32)
         ])

        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 4

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

        return horizontalStack
    }()

    
    private lazy var participantsStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        
        let titleLabel = UILabel()
        titleLabel.text = "Participantes (25)"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        let iconsStack = UIStackView()
        iconsStack.axis = .horizontal
        iconsStack.spacing = -12
        iconsStack.alignment = .center
        
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
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center
        
        let moreLabel: UILabel = {
            let label = UILabel()
            label.text = "+22"
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .darkGray
            return label
        }()

        horizontalStack.addArrangedSubview(iconsStack)
        horizontalStack.addArrangedSubview(moreLabel)

        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(horizontalStack)

        return verticalStack
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.text = "Venha celebrar meu aniversário! Teremos música ao vivo, comida boa e muita diversão. Traga um presente e um sorriso!"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var costStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        
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
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 48)
        ])
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
    
    @objc private func barButtonTapped(_ sender: UIButton) {
        self.delegate?.barButtonTapped(sender)
    }
    
    @objc private func editTapped() {
        self.delegate?.editTapped()
    }
    
    func updateDate(_ text: String) {
        if let label = dateTimeLabel.arrangedSubviews.last as? UILabel {
            label.text = text.isEmpty ? label.text : text        }
    }

    func updateLocation(_ place: String, address: String) {
        if let verticalStack = locationStack.arrangedSubviews.last as? UIStackView,
           let placeLabel = verticalStack.arrangedSubviews.first as? UILabel,
           let addressLabel = verticalStack.arrangedSubviews.last as? UILabel {
            placeLabel.text = place.isEmpty ? placeLabel.text : place
            addressLabel.text = address.isEmpty ? addressLabel.text : address
        }
    }

    func updateDescription(_ text: String) {
        descriptionText.text = text.isEmpty ? descriptionText.text : text    }

    func updateCost(_ text: String) {
        if let rightLabel = costStack.arrangedSubviews.last as? UILabel {
            rightLabel.text = text.isEmpty ? rightLabel.text : text        }
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemGroupedBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)

       // Adiciona o header à stack principal
       mainStackView.addArrangedSubview(containerHeaderStackView)
       
       // Adiciona a stack de conteúdo (com padding) à stack principal
       mainStackView.addArrangedSubview(contentInnerStackView)

       // Adiciona elementos à stack de conteúdo interna (que tem padding)
       contentInnerStackView.addArrangedSubview(dateTimeLabel)
       contentInnerStackView.setCustomSpacing(15, after: dateTimeLabel)
       
       contentInnerStackView.addArrangedSubview(locationStack)
       contentInnerStackView.setCustomSpacing(25, after: locationStack)

       contentInnerStackView.addArrangedSubview(participantsStack)
       contentInnerStackView.setCustomSpacing(25, after: participantsStack)

       contentInnerStackView.addArrangedSubview(descriptionLabel)
       contentInnerStackView.setCustomSpacing(8, after: descriptionLabel)

       contentInnerStackView.addArrangedSubview(descriptionText)
       contentInnerStackView.setCustomSpacing(15, after: descriptionText)

       contentInnerStackView.addArrangedSubview(costStack)
       contentInnerStackView.setCustomSpacing(24, after: costStack)

       contentInnerStackView.addArrangedSubview(confirmButton)
   }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            // MainStackView (dentro da ScrollView)
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            // Componentes dentro do containerHeaderStackView
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: 0.6),
            
            // containerHeaderStackView já está na mainStackView, que tem widthAnchor = scrollView.frameLayoutGuide.widthAnchor.
            // Isso fará com que o header ocupe toda a largura.

            // contentInnerStackView também está na mainStackView e ocupará toda a largura.
            // O padding é aplicado internamente por contentInnerStackView.layoutMargins.
            
            // O confirmButton já tem sua altura definida na inicialização.
            // Sua largura será gerenciada pela contentInnerStackView (que tem padding).
        ])
    }
}
