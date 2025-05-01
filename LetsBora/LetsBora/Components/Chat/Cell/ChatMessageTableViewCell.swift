//
//  ChatMessageTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {
    
    static let identifier = String(
        describing: ChatMessageTableViewCell.self
    )
    
    struct cellLayout {
        static let height: CGFloat = 100
        static let heightBallon: CGFloat = 40
        static let marginVertical: CGFloat = 8
        static let marginHorizontal: CGFloat = 16
        static let avatarSize: CGFloat = 40
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var avatarImageView = AvatarImageView(
        size: cellLayout.avatarSize,
        borderWidth: 0
    )
    lazy var nameLabel = ReusableLabel(
        labelType: .caption,
        colorStyle: .tertiary
    )
    lazy var ballonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = cellLayout.height / 8
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.numberOfLines = 0 // Allow unlimited lines
        label.lineBreakMode = .byWordWrapping // Wrap text by word
        label.adjustsFontSizeToFitWidth = false // Keep original size unless you want to shrink
        
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    // MARK: - Setup e configs
    func setupUI() {
        contentView.backgroundColor = .systemGray6
    }
    
    func setupCell(with chat: Chat){
        guard let user = chat.user else { return }
        guard let activeOwner = chat.activeOwner else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let _ = chat.date ?? formatter.string(from: Date())
        let _ = chat.seen ?? false
        
        
        avatarImageView.setImage(named: user.photo ?? "")
        nameLabel.setText(user.name)
        
        if activeOwner {
            ballonView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            ballonView.trailing(
                anchor: containerView.trailingAnchor,
                constant: -cellLayout.avatarSize
            )
            avatarImageView.trailing(anchor: containerView.trailingAnchor)
            nameLabel.trailing(
                anchor: avatarImageView.leadingAnchor,
                constant: -cellLayout.marginHorizontal / 2
            )
            ballonView.layer.maskedCorners = [
                .layerMaxXMaxYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ]
            
        } else {
            ballonView.backgroundColor = .white
            messageLabel.textColor = .black
            ballonView.leading(
                anchor: containerView.leadingAnchor,
                constant: cellLayout.avatarSize
            )
            avatarImageView.leading(anchor: containerView.leadingAnchor)
            nameLabel.leading(
                anchor: avatarImageView.trailingAnchor,
                constant: cellLayout.marginHorizontal / 2
            )
            ballonView.layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner
                
            ]
        }
        messageLabel.text = chat.text
        
    }
    
}

extension ChatMessageTableViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(avatarImageView)
        containerView.addSubview(ballonView)
        containerView.addSubview(nameLabel)

        ballonView.addSubview(messageLabel)
    }
    
    func setConstraints() {
        containerView
            .top(
                anchor: contentView.topAnchor,
                constant: cellLayout.marginVertical
            )
            .bottom(
                anchor: contentView.bottomAnchor,
                constant: -cellLayout.marginVertical
            )
            .leading(
                anchor: contentView.leadingAnchor,
                constant: cellLayout.marginHorizontal
            )
            .trailing(
                anchor: contentView.trailingAnchor,
                constant: -cellLayout.marginHorizontal
            )
            .height(
                anchor: ballonView.heightAnchor,
                constant: cellLayout.avatarSize + cellLayout.marginVertical
            )
        
        avatarImageView
            .top(anchor: containerView.topAnchor)
        
        nameLabel
            .centerY(avatarImageView.centerYAnchor)
        
        ballonView
            .top(
                anchor: containerView.topAnchor,
                constant: cellLayout.avatarSize
            )
            .height(
                anchor: messageLabel.heightAnchor,
                constant: cellLayout.marginVertical
            )
            .width(
                anchor: messageLabel.widthAnchor,
                constant: cellLayout.marginHorizontal
            )
        
        messageLabel
            .centerX(ballonView.centerXAnchor)
            .centerY(ballonView.centerYAnchor)
            .widthAnchor.constraint(
                lessThanOrEqualTo: containerView.widthAnchor,
                multiplier: 0.85).isActive = true
        
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    ChatViewController()
})

