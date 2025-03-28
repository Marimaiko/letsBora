//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .white  // Ensure background is not black
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(homeView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)  // Ensures full screen usage
        ])
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})


