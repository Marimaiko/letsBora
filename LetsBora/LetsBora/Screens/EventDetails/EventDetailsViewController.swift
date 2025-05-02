//
//  EventDetailsViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 11/04/25.
//

import Foundation
import UIKit

class EventDetailsViewController: UIViewController {
    // MARK: - UI Components
    let eventDetailsView = EventDetailsView()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func loadView() {
        self.view = eventDetailsView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        eventDetailsView.delegate = self
    }

    // MARK: - Setup
    private func setupNavigation() {
        // Set the title and button
        title = "Detalhes Aniversário do Pedro"
    }
}
extension EventDetailsViewController: EventDetailsViewDelegate {
    func barButtonTapped
    (_ sender: UIButton
    ) {
        if(sender.tag == EventDetailsView.TabTag.chat.rawValue){
            navigationController?.pushViewController(
                ChatViewController(),
                animated: true
            )
        }
    }
}

@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    EventDetailsViewController()
})
