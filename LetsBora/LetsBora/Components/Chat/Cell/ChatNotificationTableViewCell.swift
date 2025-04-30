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
        return view
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  // MARK: - Setup e Configs
   func setupCell(with chat: Chat){
       messageLabel.text = chat.text
    }
}
extension ChatNotificationTableViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(baloonView)
        baloonView.addSubview(messageLabel)
    }
    
    func setConstraints() {
        baloonView
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
        
        messageLabel
            .top(
                anchor: baloonView.topAnchor,
                constant: cellLayout.marginVertical
            )
            .bottom(
                anchor: baloonView.bottomAnchor,
                constant: -cellLayout.marginVertical
            )
            .leading(
                anchor: baloonView.leadingAnchor,
                constant: cellLayout.marginHorizontal
            )
            .trailing(
                anchor: baloonView.trailingAnchor,
                constant: -cellLayout.marginHorizontal
            )
            
    }
    
    
}


