//
//  ChatViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

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
        setupNavigation()
        chatView.tableView.dataSource = self
        chatView.tableView.register(
            ChatNotificationTableViewCell.self,
            forCellReuseIdentifier: ChatNotificationTableViewCell.identifier
        )
    }
    private func setupNavigation() {
        title = "Detalhes Aniversário do Pedro"
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
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatNotificationTableViewCell.identifier,
            for: indexPath
        ) as? ChatNotificationTableViewCell
        
        cell?.setupCell(with: chats[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    
}
