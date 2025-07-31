//
//  NotificationDetailViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 31/07/25.
//
import UIKit

class NotificationDetailViewController: UIViewController {

    private var screen: NotificationDetailView?
    private var viewModel: NotificationDetailViewModel
    
    // Init
    init(notification: MessageNotification) {
        self.viewModel = NotificationDetailViewModel(message: notification)
        
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // View lifecycle
    override func loadView() {
        screen = NotificationDetailView()
        view = screen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(self)
        Task {[weak self] in
            guard let self = self else {return}
            
            let sender = await viewModel.getSender()
            guard let sender = sender else {
                self.screen?.configure(message: viewModel.message)
                return
            }
            self.screen?.configure(message: viewModel.message, from: sender)
        }
    }
    
    
}
extension NotificationDetailViewController: NotificationDetailViewDelegate {
    func didTapDismissButton() {
        dismiss(animated: true)
    }
}
