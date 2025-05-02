//
//  LoginViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 26/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let loginView = LoginView()
        loginView.delegate = self
        self.view = loginView
    }
}
extension LoginViewController: LoginViewDelegate {
    func didTapLoginButton() {
        let tabBarController = TabBarController()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        
        // Ensure we access the correct scene delegate
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    LoginViewController()
})
