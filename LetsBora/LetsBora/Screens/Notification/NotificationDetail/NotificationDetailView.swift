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

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fechar", for: .normal)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel, closeButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    @objc private func dismissSelf() {
        delegate?.didTapDismissButton()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .clear 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(message: MessageNotification){
        titleLabel.text = message.title
        messageLabel.text = message.text
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
