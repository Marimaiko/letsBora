//
//  LoginViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 26/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
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
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
        }
    }
    
    func didTapCreateAccount() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    LoginViewController()
})
#endif
