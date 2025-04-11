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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }
    
    // MARK: - Setup
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setupNavigation() {
        title = "Detalhes Aniversário do Pedro"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    private func setHierarchy() {
        view.backgroundColor = .white
        view.addSubview(eventDetailsView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            eventDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            eventDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
