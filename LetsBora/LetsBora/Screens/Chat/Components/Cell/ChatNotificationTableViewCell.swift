//
//  ChatNotificationTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

class ChatNotificationTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ChatNotificationTableViewCell.self )
    
    struct cellLayout{
        static let marginVertical: CGFloat = 8
        static let marginHorizontal: CGFloat = 16
        static let fontSize: CGFloat = 16
    }
    
    lazy var ballonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: cellLayout.fontSize, weight: .regular)
        
        return label
    }()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  // MARK: - Setup e Configs
    func setupUI(){
        contentView.backgroundColor = .systemGray6
    }
   func setupCell(with chat: Chat){
       messageLabel.text = chat.text
    }
}
extension ChatNotificationTableViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(ballonView)
        ballonView.addSubview(messageLabel)
    }
    
    func setConstraints() {
        messageLabel
            .centerX(ballonView.centerXAnchor)
            .centerY(ballonView.centerYAnchor)
        
        ballonView
            .centerX(contentView.centerXAnchor)
            .centerY(contentView.centerYAnchor)
            .height(
                anchor: messageLabel.heightAnchor,
                constant: cellLayout.marginVertical
            )
            .width(
                anchor: messageLabel.widthAnchor,
                constant: cellLayout.marginHorizontal
            )
            .top(
                anchor: contentView.topAnchor,
                constant: cellLayout.marginVertical
            )
            .bottom(
                anchor: contentView.bottomAnchor,
                constant: -cellLayout.marginVertical
            )
    }
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ChatViewController()
})
#endif
