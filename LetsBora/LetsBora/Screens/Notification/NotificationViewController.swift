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
    }
    
}
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfNotifications
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: NotificationTableViewCell.identifier,
                for: indexPath
            ) as? NotificationTableViewCell else {
            return UITableViewCell()
        }
        
        let notification = self.viewModel.getNotificationByIndex(indexPath.row)
        cell.configure(with: notification)
        return cell
    }
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    NotificationViewController()
})
#endif
