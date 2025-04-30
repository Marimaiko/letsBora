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
    }

    // MARK: - Setup
    private func setupNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        
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
