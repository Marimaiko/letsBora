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
    private lazy var eventDetailsView: EventDetailsView = {
        let view = EventDetailsView()
        return view
    }()
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view = eventDetailsView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        title = "Detalhes Aniversário do Pedro"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    EventDetailsViewController()
})
