//
//  ChatViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

//TODO: Fazer separação com view model; chat private
class ChatViewController: UIViewController {
    var screen: ChatView?
    var viewModel: ChatViewModel?
    
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
        screen = ChatView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChatViewModel()
        setupUI()
        
    }
    func setupUI() {
        screen?.tableView.dataSource = self
        screen?.tableView.register(
            ChatNotificationTableViewCell.self,
            forCellReuseIdentifier: ChatNotificationTableViewCell.identifier
        )
        screen?.tableView.register(
            ChatMessageTableViewCell.self,
            forCellReuseIdentifier: ChatMessageTableViewCell.identifier
        )
        screen?.tableView.register(
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
        return viewModel?.chats?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let chat = viewModel?.chats?[indexPath.row] else {
            return UITableViewCell()
        }
        
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
