//
//  RegisterViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/04/25.
//

import UIKit

class RegisterViewController: UIViewController, RegisterViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            false, animated: animated)
    }
    
    override func loadView() {
        let registerView = RegisterView()
        registerView.delegate = self
        self.view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        
        // Apply to both standard and scroll edge appearances
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Optionally also compact appearance
        navigationController?.navigationBar.compactAppearance = appearance

        // Set the title and button
        title = "Registrar-se"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
    }
 @objc func backButtonTapped() {
     navigationController?.popViewController(animated: true)
    }
    func didTapRegister() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    RegisterViewController()
})
