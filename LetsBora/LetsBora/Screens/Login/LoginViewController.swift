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
            print("Validação de login falhou.")
            return
            // Opcional: Mostrar um alerta geral se houver muitos erros ou se preferir
            // let alert = UIAlertController(title: "Erro de Login", message: "Por favor, corrija os campos destacados.", preferredStyle: .alert)
            // alert.addAction(UIAlertAction(title: "OK", style: .default))
            // present(alert, animated: true)
        }
        
        Task {
            let success = await viewModel?.login(
                email: authToLogin.email,
                password: authToLogin.password
            ) ?? false
            
            if success {
                navigateToHome()
            } else {
                print("Login Failed")
                return
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
