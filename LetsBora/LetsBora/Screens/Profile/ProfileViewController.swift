//
//  ProfileViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 01/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
    }
    
    override func loadView() {
        self.view = profileView
    }
}
extension ProfileViewController: ProfileViewDelegate {
    func exitProfileDidTapButton() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = LoginViewController()
            window.makeKeyAndVisible()
        }
    }
    
    func profileViewDidTapEditButton() {
        let profileEditViewController = ProfileEditViewController()
        profileEditViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}
// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileViewController()
})
