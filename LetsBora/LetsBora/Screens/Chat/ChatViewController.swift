//
//  ChatViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

//TODO: Fazer separação com view model; chat private
class ChatViewController: UIViewController {
    let chats: [Chat] = MockData.chats
    
    let chatView = ChatView()
    
    // MARK: - LyfeCycle
    override func viewWillAppear(
        _ animated: Bool
    ) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            false,
            animated: animated
        )
    }
    override func loadView() {
        self.view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    func setupUI() {
        chatView.tableView.dataSource = self
        chatView.tableView.register(
            ChatNotificationTableViewCell.self,
            forCellReuseIdentifier: ChatNotificationTableViewCell.identifier
        )
        chatView.tableView.register(
            ChatMessageTableViewCell.self,
            forCellReuseIdentifier: ChatMessageTableViewCell.identifier
        )
        chatView.tableView.register(
            ChatSurveyTableViewCell.self,
            forCellReuseIdentifier: ChatSurveyTableViewCell.identifier
        )
    }
    
}
extension ChatViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return chats.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let chat = chats[indexPath.row]
        
        switch chat.type {
            
        case .notification:
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatNotificationTableViewCell.identifier,
                for: indexPath
            ) as? ChatNotificationTableViewCell
            cell?.setupCell(with: chat)
            
            return cell ?? UITableViewCell()
            
        case .message:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatMessageTableViewCell.identifier,
                for: indexPath
            ) as? ChatMessageTableViewCell
            cell?.setupCell(with: chat)
            
            return cell ?? UITableViewCell()
            
        case .survey:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatSurveyTableViewCell.identifier,
                for: indexPath
            ) as? ChatSurveyTableViewCell
            cell?.setupCell(with: chat)
            
            return cell ?? UITableViewCell()
            
        }
    }
}
// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    ChatViewController()
})

#endif
