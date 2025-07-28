//
//  ProfileEditViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

//TODO: Fazer separação com view model
class ProfileEditViewController: UIViewController {
    private let mainView = ProfileEditView()
    private let viewModel = ProfileEditViewModel()
    
    var onProfileUpdated: ((User) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Editar Perfil"
        mainView.delegate = self
        fetchAndDisplayUserData()
    }
    
    private func fetchAndDisplayUserData() {
        mainView.showLoading(true)
        Task {
            do {
                let user = try await viewModel.fetchCurrentUser()
                await MainActor.run {
                    mainView.configure(with: user)
                    mainView.showLoading(false)
                }
            } catch {
                mainView.showLoading(false)
                print("Erro ao buscar dados do usuário: \(error.localizedDescription)")
                // TODO: Mostrar um alerta para o usuário
            }
        }
    }
    
    private func handleUpdate(name: String, email: String, newPassword: String) {
        mainView.showLoading(true)
        Task {
            do {
                let updatedUser = try await viewModel.updateUser(name: name, email: email, newPassword: newPassword.isEmpty ? nil : newPassword)
                
                Utils.saveLoggedInUser(updatedUser)
                
                await MainActor.run {
                    mainView.showLoading(false)
                    self.onProfileUpdated?(updatedUser)

                    if email != viewModel.originalEmail {
                        let alert = UIAlertController(
                            title: "Verifique seu E-mail",
                            message: "Seu nome foi atualizado com sucesso. Enviamos um link de verificação para \(email). Por favor, clique no link para concluir a alteração do seu e-mail.",
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                await MainActor.run {
                    mainView.showLoading(false)
                    print("Erro ao atualizar perfil: \(error.localizedDescription)")
                    let errorAlert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(errorAlert, animated: true)
                }
            }
        }
    }
}

extension ProfileEditViewController: ProfileEditViewDelegate {
    func didTapSaveButton(name: String, email: String, newPassword: String, confirmPassword: String) {
        // Validação básica
        if newPassword != confirmPassword {
            print("As senhas não correspondem!")
            // TODO: Mostrar um alerta para o usuário
            return
        }
        
        // Chama a função para lidar com a atualização
        handleUpdate(name: name, email: email, newPassword: newPassword)
    }
    
    func profileViewDidTapEditButton() {
        let profileEditViewController = ProfileEditViewController()
        profileEditViewController.onProfileUpdated = { [weak self] updatedUser in
            print("Perfil atualizado para: \(updatedUser.name)")
        }
        profileEditViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditViewController()
})
#endif
