//
//  ChatViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit

class ChatViewController: UIViewController {
    let chats: Chat = 
    
    let chatView = ChatView()
    
    // MARK: - LyfeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func loadView() {
        self.view = chatView
        setupNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.tableView.delegate = self
    }
    
    private func setupNavigation() {
        title = "Detalhes Aniversário do Pedro"
    }
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
