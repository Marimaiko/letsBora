//
//  ChatView.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

class ChatView: UIView {
    
    private lazy var chatTabBarView: ChatTabBarView = {
       let chatBar = ChatTabBarView()
            return chatBar
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.backgroundColor =  .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    // MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemGray6
        setupView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension ChatView:ViewCode{
    func setHierarchy() {
        self.addSubview(tableView)
        self.addSubview(chatTabBarView)
    }
    
    func setConstraints() {
        tableView
            .top(anchor: self.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: self.leadingAnchor)
            .trailing(anchor: self.trailingAnchor)
            .bottom(anchor: chatTabBarView.topAnchor)
        
        chatTabBarView
            .bottom(anchor: self.bottomAnchor)
            .leading(anchor: self.leadingAnchor)
            .trailing(anchor: self.trailingAnchor)
            .height(constant: ChatTabBarView.InternalLayout.containerHeight)
        
    }

}
// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    ChatViewController()
})

