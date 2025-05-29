//
//  LoginViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 26/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginScreen: LoginView? {
        return view as? LoginView
    }
    private var viewModel: LoginViewModel?
    
    private lazy var alert: AlertController = {
        let alert = AlertController(controller: self)
        return alert
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let loginView = LoginView()
        loginView.delegate(self)
        viewModel = LoginViewModel()
        self.view = loginView
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func performValidation() ->AuthUser? {
        guard let screen = loginScreen else { return nil }
        
        screen.resetErrorMessages() // Limpa erros anteriores
        var isValid = true
        
        // Validar Email
        let email = screen.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if email.isEmpty {
            screen.displayEmailError("Email é obrigatório.")
            isValid = false
        } else if !isValidEmail(email) {
            screen.displayEmailError("Formato de email inválido.")
            isValid = false
        }
        
        // Validar Senha
        let password = screen.passwordTextField.text ?? ""
        if password.isEmpty {
            screen.displayPasswordError("Senha é obrigatória.")
            isValid = false
        } else if password.count < 6 { // Exemplo: mínimo de 6 caracteres
            screen.displayPasswordError("Senha deve ter pelo menos 6 caracteres.")
            isValid = false
        }
        
        if (isValid){
            return AuthUser(email: email, password: password)
        }
        
        return nil
    }
}
extension LoginViewController: LoginViewDelegate {
    private func navigateToHome() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
        }
    }
    
    func didTapLoginButton() {
        
        guard let authToLogin = performValidation() else {
            alert.showAlert(
                title: "Erro de Login",
                message: "Por favor, corrija os campos destacados."
            )
            return
        }
        
        Task {
            do {
                try await viewModel?.login(
                    email: authToLogin.email,
                    password: authToLogin.password
                )
                navigateToHome()
            } catch {
                let message = error as? LocalizedError
                alert.showAlert(
                    title: "Erro",
                    message: message?.errorDescription ?? "Erro ao fazer login. Por favor, tente novamente mais tarde."
                )
                print("Login Failed: \(error)")
            }
        }
        
    }
    
    func didTapCreateAccount() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func didTapForgetPassword() {
        let forgetPasswordVC = ForgetPasswordViewController()
        navigationController?.pushViewController(forgetPasswordVC, animated: true)
    }
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    LoginViewController()
})
#endif
