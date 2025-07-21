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
        static let marginVertical: CGFloat = 12
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
    lazy var dateLabel = ReusableLabel(
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
        label.font = .systemFont(ofSize: 18, weight: .regular)
        
        label.textAlignment = .natural
        label.numberOfLines = 0 // Allow unlimited lines
        label.lineBreakMode = .byWordWrapping // Wrap text by word
        label.adjustsFontSizeToFitWidth = false // Keep original size unless you want to shrink
        
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    // MARK: - Constraint Groups
    private var ownerConstraints: [NSLayoutConstraint] = []
    private var otherConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupUI()
        setupConstraintGroups()
    }
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    // MARK: - Setup e configs
    func setupUI() {
        contentView.backgroundColor = .systemGray6
    }
    
    func checkActiveOwner(_ user: User) -> Bool{
        let owner:User? = Utils.getLoggedInUser()
        guard let loggedUserId = owner?.id else { return false }
        if(loggedUserId == user.id ){
            return true
        }
        return false
    }
    
    func setupCell(with chat: Chat){
        guard let user = chat.user else { return }
        let activeOwner = checkActiveOwner(user)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = chat.date ?? formatter.string(from: Date())
        let _ = chat.seen ?? false
        
        
        avatarImageView.setImage(named: user.photo ?? "")
        nameLabel.updateText(user.name)
        
        dateLabel.text = date
        messageLabel.text = chat.text
        
        ballonView.backgroundColor = activeOwner ? .systemBlue : .white
        messageLabel.textColor = activeOwner ? .white : .black
        ballonView.layer.maskedCorners = activeOwner
                    ? [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
                    : [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        NSLayoutConstraint.deactivate(ownerConstraints + otherConstraints)
        NSLayoutConstraint.activate(activeOwner ? ownerConstraints : otherConstraints)
        
    }
    private func setupConstraintGroups() {
        // Constraints do dono da mensagem (à direita)
        ownerConstraints = [
            ballonView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -cellLayout.avatarSize
            ),
            avatarImageView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: avatarImageView.leadingAnchor,
                constant: -cellLayout.marginHorizontal / 2
            ),
            dateLabel.trailingAnchor.constraint(
                equalTo: ballonView.trailingAnchor
            )
        ]
        
        // Constraints de outras pessoas (à esquerda)
        otherConstraints = [
            avatarImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 8
            ),
            ballonView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: cellLayout.avatarSize
            ),
            dateLabel.leadingAnchor.constraint(
                equalTo: ballonView.leadingAnchor
            )
        ]
    }
}

extension ChatMessageTableViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(avatarImageView)
        containerView.addSubview(ballonView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(dateLabel)
        
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
        
        dateLabel
            .top(
                anchor: ballonView.bottomAnchor,
                constant: cellLayout.marginVertical / 2
            )
    }
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    ChatViewController(
        with: .init(
            messages: [
                MockData.chat3,
                MockData.chat4,
                MockData.chat5,
                MockData.chat3,
                MockData.chat4,
                MockData.chat5,
                MockData.chat3,
                MockData.chat4,
                MockData.chat5,
                MockData.chat3,
                MockData.chat4,
                MockData.chat5,
            ]
        )
    )
})
#endif
