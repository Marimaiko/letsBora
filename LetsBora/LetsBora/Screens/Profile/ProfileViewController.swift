//
//  ProfileViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 01/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    private let profileView = ProfileView()
    private let viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadUserProfileData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.delegate = self
    }
    
    override func loadView() {
        self.view = profileView
    }
    
    private func loadUserProfileData() {
        profileView.showLoading(true)
        Task {
            do {
                let profileData = try await viewModel.fetchUserProfileData()
                
                await MainActor.run {
                    profileView.configure(with: profileData)
                    profileView.showLoading(false)
                }
            } catch {
                await MainActor.run {
                    profileView.showLoading(false)
                    showAlert(title: "Erro", message: "Não foi possível carregar seu perfil. Por favor, tente novamente.")
                }
            }
        }
    }
                        
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
                try await viewModel.logout()
                navigateToLogin()
            } catch {
                print("Failed to logout user: \(error.localizedDescription)")
            }
        }
    }
    
    //TODO: Poderia ser uma modal, por ser uma tela mais simples
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
