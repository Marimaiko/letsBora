//
//  NotificationDetailView.swift
//  LetsBora
//
//  Created by Davi Paiva on 31/07/25.
//

import UIKit
protocol NotificationDetailViewDelegate: AnyObject {
    func didTapDismissButton()
}
class NotificationDetailView: UIView {
    private weak var delegate: NotificationDetailViewDelegate?
    
    func delegate(_ delegate: NotificationDetailViewDelegate?) {
        self.delegate = delegate
    }
    
    // Fundo escurecido
    private lazy var dimmedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Caixinha flutuante
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    private lazy var messageFrom: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    private lazy var messageDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Fechar"
        config.cornerStyle = .medium
        config.baseBackgroundColor = .lightGray
        config.baseForegroundColor = .white
        config.titleAlignment = .center
        button.configuration = config
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        return button
    }()

    private lazy var goToEventButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Visualizar Evento"
        config.image = UIImage(systemName: "calendar")
        config.imagePadding = 16
        config.imagePlacement = .leading
        config.cornerStyle = .small
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.titleAlignment = .center
        button.configuration = config
        button.addTarget(self, action: #selector(goToEvent), for: .touchUpInside)
        return button
    }()

    private lazy var markAsReadedButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Marcar como Lido"
        config.cornerStyle = .medium
        config.baseBackgroundColor = .systemGreen
        config.baseForegroundColor = .white
        config.titleAlignment = .center
        button.configuration = config
        button.addTarget(self, action: #selector(markAsReaded), for: .touchUpInside)
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [closeButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    private lazy var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [titleLabel, messageDate])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    @objc private func dismissSelf() {
        delegate?.didTapDismissButton()
    }
    @objc private func goToEvent() {
        
    }
    @objc private func markAsReaded(){
        
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        message: MessageNotification,
        from: User? = nil
    ){
        titleLabel.text = message.title
        messageDate.text = message.createdAt.toString()
        
        if let user = from {
            if !stackView.arrangedSubviews.contains(messageFrom){
                messageFrom.text = "De: \(user.name) \(user.email ?? "")"
                stackView.addArrangedSubview(messageFrom)
            }
        }
        
        messageLabel.text = message.text
        if !stackView.arrangedSubviews.contains(messageLabel){
            stackView.addArrangedSubview(messageLabel)
        }
        
        
        if let _ = message.eventID {
            goToEventButton.setTitle("Visualizar Evento", for: .normal)
            if !stackView.arrangedSubviews.contains(goToEventButton) {
                stackView.addArrangedSubview(goToEventButton)
            }
        }
        
        if(!message.isRead){
            if !buttonStackView.arrangedSubviews.contains(markAsReadedButton){
                buttonStackView.addArrangedSubview(markAsReadedButton)
            }
        }
        
        if !stackView.arrangedSubviews.contains(buttonStackView){
            stackView.addArrangedSubview(buttonStackView)
        }
    }
}
extension NotificationDetailView: ViewCode {
    func setHierarchy() {
        addSubview(dimmedBackgroundView)
        addSubview(containerView)
        containerView.addSubview(stackView)
    }
    
    func setConstraints() {
        dimmedBackgroundView
            .top(anchor: topAnchor)
            .leading(anchor: leadingAnchor)
            .trailing(anchor: trailingAnchor)
            .bottom(anchor: bottomAnchor)
        
        containerView
            .centerX(centerXAnchor)
            .centerY(centerYAnchor)
            .width(to: widthAnchor, multiplier: 0.8)
        
        stackView
            .top(anchor: containerView.topAnchor, constant: 24)
            .leading(anchor: containerView.leadingAnchor, constant: 16)
            .trailing(anchor: containerView.trailingAnchor, constant: -16)
            .bottom(anchor: containerView.bottomAnchor, constant: -24)
        
    }
    
    
}
