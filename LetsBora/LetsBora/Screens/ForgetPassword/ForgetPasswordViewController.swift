//
//  ForgetPasswordViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 22/05/25.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    var screen: ForgetPasswordView?
    var viewModel: ForgetPasswordViewModel?
    
    private lazy var alert: AlertController = {
        let alert = AlertController(controller: self)
        return alert
    }()
    
    override func loadView() {
        screen = ForgetPasswordView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate = self
        viewModel = ForgetPasswordViewModel()
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension ForgetPasswordViewController: ForgetPasswordDelegate {
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func didTapSendEmail() {
        // get email from screen
        guard let email = screen?.getEmailText() else {
            alert.showAlert(
                title: "Erro",
                message: "Insira um email no campo de e-mail"
            )
            return
        }
        // check if email is valid
        if !isValidEmail(email) {
            alert.showAlert(
                title: "Erro",
                message: "Email inválido"
            )
            return
        }
        // perform reset password task
        Task {
            do {
                try await viewModel?.resetPassword(email: email)
                alert.showAlert(
                    title: "Sucesso",
                    message: "senha de redefinição enviada com sucesso para \(email)"
                ){
                    self.navigateBack()
                }
                
            } catch {
                print(error)
                let message = error as? LocalizedError
                print(message?.errorDescription ?? "error not localized")
                
                alert.showAlert(
                    title: "Erro",
                    message: message?.errorDescription ?? "Erro ao redefinir senha. Por favor, tente novamente mais tarde."
                ){
                }
            }
        }
        
        
    }
    
    func didTapCancel() {
        navigateBack()
    }
}
