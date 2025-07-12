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
    var viewModel: ChatViewModel
    // MARK: - Init
    init(with chat: ChatGroup) {
        viewModel = ChatViewModel(chat)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        screen?.delegateChatTabBarView(with: self)
    }
    
}
extension ChatViewController: ChatTabBarViewDelegate {
    func chatTabBarViewDidTapSendButton(_ chatTabBarView: ChatTabBarView) {
        print("Send Button Tapped")
        print("\(chatTabBarView.getText())")
    }
    
    func chatTabBarViewDidTapMicrofoneButton(_ chatTabBarView: ChatTabBarView) {
        print("Microphone Button Tapped")
    }
    
    func chatTabBarViewDidTapPlusButton(_ chatTabBarView: ChatTabBarView) {
        print("Plus Button Tapped")
    }
    
    
}
extension ChatViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.chatGroup.messages.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let chat = viewModel.chatGroup.messages[indexPath.row]
        
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
    ChatViewController(
        with: .init(
            messages: [
                MockData.chat1
            ]
        )
    )
})

#endif
