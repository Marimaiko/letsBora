//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /// before didLoad used to ref view
    override func loadView() {
        self.view = HomeView()
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})


