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
        static let height: CGFloat = 44
        static let marginVertical: CGFloat = 8
        static let marginHorizontal: CGFloat = 16
    }
    
    lazy var baloonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        
        view.clipsToBounds = true
        view.layer.cornerRadius = cellLayout.height / 4
        return view
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
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
        contentView.backgroundColor = .clear
    }
   func setupCell(with chat: Chat){
       print("setupCell \(chat)")
       messageLabel.text = chat.text
    }
}
extension ChatNotificationTableViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(baloonView)
        baloonView.addSubview(messageLabel)
    }
    
    func setConstraints() {
        messageLabel
            .centerX(baloonView.centerXAnchor)
            .centerY(baloonView.centerYAnchor)
        
        baloonView
            .centerX(contentView.centerXAnchor)
            .centerY(contentView.centerYAnchor)
            .height(constant: cellLayout.height)
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
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ChatViewController()
})

