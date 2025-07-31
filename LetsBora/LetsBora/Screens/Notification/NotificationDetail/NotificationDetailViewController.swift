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
    var onDismiss: (() -> Void)?
    
    // Init
    init(
        notification: Notification,
        index: Int
    ) {
        self.viewModel = NotificationDetailViewModel(notification: notification, index: index)
        
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
    func didTapGoToEvent() {
        
    }
    
    func didTapMarkAsReaded() {
        Task {[weak self] in
            guard let self = self else {
                return
            }
            await self.viewModel.markAsReaded()
            onDismiss?()
            dismiss(animated: true)
        }
    }
    
    func didTapDismissButton() {
        onDismiss?()
        dismiss(animated: true)
    }
}
