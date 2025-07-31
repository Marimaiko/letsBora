//
//  NotificationViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/07/25.
//

import UIKit

class NotificationViewController: UIViewController{
    private var screen: NotificationView?
    private var viewModel: NotificationViewModel
    var onDismiss: (() -> Void)?
    
    // MARK: - Init
    init(){
        viewModel = NotificationViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LyfeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func loadView(){
        screen = NotificationView()
        view = screen
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Notificações"
        screen?.registerCell(NotificationTableViewCell.self)
        screen?.delegateTableView(self, self)
        Task { [weak self] in
            guard let self else { return }
            
            do {
                try await viewModel.loadNotifications()
                self.screen?.reloadTable()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent { 
            onDismiss?()
        }
    }
    
}
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: NotificationTableViewCell.identifier,
                for: indexPath
            ) as? NotificationTableViewCell else {
            return UITableViewCell()
        }
        
        let notification = self.viewModel.getNotificationByIndex(indexPath.section)
        
        guard let notification = notification else {
            return UITableViewCell()
        }
        
        cell.configure(with: notification )
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfNotifications
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Uma célula por seção
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12 // Espaçamento entre as "células"
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let notificationGroup = viewModel.notificationGroup else {
            return
        }
        let detailVC = NotificationDetailViewController(notification: notificationGroup, index: indexPath.section)
        // Quando fechar, recarrega a tabela
        detailVC.onDismiss = { [weak self] in
            Task{
                try await self?.viewModel.loadNotifications()
                self?.screen?.reloadTable()
            }
            
        }
        present(detailVC, animated: true)
    }
    
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    NotificationViewController()
})
#endif
