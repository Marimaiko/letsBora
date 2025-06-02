//
//  ProfileViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 01/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    var profileView : ProfileView?
    var viewModel: ProfileViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView?.delegate = self
        viewModel = ProfileViewModel()
    }
    
    override func loadView() {
        profileView = ProfileView()
        self.view = profileView
    }
}
extension ProfileViewController: ProfileViewDelegate {
    func navigateToLogin(){
        
        if let sceneDelegate = UIApplication
            .shared
            .connectedScenes
            .first?
            .delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            let rootViewController = LoginViewController()
            let navController = UINavigationController(rootViewController: rootViewController)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
    func exitProfileDidTapButton() {
        Task{
            do {
                try await viewModel?.logout()
                navigateToLogin()
            } catch {
                print("Failed to logout user: \(error.localizedDescription)")
            }
        }
    }
    
    func profileViewDidTapEditButton() {
        let profileEditViewController = ProfileEditViewController()
        profileEditViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}
// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    ProfileViewController()
})
#endif
