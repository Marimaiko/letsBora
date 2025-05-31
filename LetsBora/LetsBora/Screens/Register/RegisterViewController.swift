//
//  RegisterViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/04/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController, RegisterViewDelegate {
    
    var registerView: RegisterView?
    var viewModel: RegisterViewModel?
    
    private var screen: RegisterView? {
        return self.view as? RegisterView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            false, animated: animated)
    }
    
    override func loadView() {
        viewModel = RegisterViewModel()
        registerView = RegisterView()
        registerView?.delegate = self
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
    
    // Função helper para validar email
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Função para validar os inputs
    private func validateInputs() -> User? {
        guard let screen = self.screen else { return nil }
        
        screen.resetAllErrorVisuals()
        var isValid = true
        
        // Validar Nome
        let name = screen.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if name.isEmpty {
            screen.displayNameError("Nome é obrigatório.")
            isValid = false
        } else if name.count < 2 {
            screen.displayNameError("Nome deve ter pelo menos 2 caracteres.")
            isValid = false
        }
        
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
        let password = screen.passwordTextField.text ?? "" // Não trimar senha
        if password.isEmpty {
            screen.displayPasswordError("Senha é obrigatória.")
            isValid = false
        } else if password.count < 6 {
            screen.displayPasswordError("Senha deve ter pelo menos 6 caracteres.")
            isValid = false
        }
        
        // (Opcional) Validar Confirmação de Senha
        // let confirmPassword = screen.confirmPasswordTextField.text ?? ""
        // if confirmPassword.isEmpty {
        //     screen.displayConfirmPasswordError("Confirmação de senha é obrigatória.")
        //     isValid = false
        // } else if password != confirmPassword {
        //     screen.displayConfirmPasswordError("As senhas não coincidem.")
        //     isValid = false
        // }
        
        if isValid {
            // Se tudo for válido, cria o objeto User.
            // O ID e photo serão definidos pelo backend/viewModel.
            return User(name: name, email: email, password: password)
        } else {
            return nil
        }
    }
    
    func didTapRegister() {
        if let validUser = validateInputs() {
            // print("Validação de registro bem-sucedida. Usuário: \(validUser.name), Email: \(validUser.email)")
            Task {
                // O viewModel.signUp espera um User com email e senha.
                // O User que passamos já tem esses campos.
                // O viewModel internamente criará outro User com o ID do Auth.
                await viewModel?.signUp(user: validUser) //
                
                // Após o signUp, você pode querer navegar para outra tela
                // ou mostrar uma mensagem de sucesso/erro baseada na resposta do viewModel.
                // Ex: verificar se o usuário foi realmente criado e está logado.
                // Por enquanto, vamos apenas imprimir.
                print("Chamada ao viewModel.signUp concluída.")
                // Exemplo de navegação para a tela de login ou principal após registro bem-sucedido:
                 navigationController?.popToRootViewController(animated: true)
                // ou mostrar um alerta de sucesso e pedir para o usuário logar.
            }
        } else {
            print("Validação de registro falhou.")
            // Erros já foram exibidos na tela.
            // Opcional: Mostrar um alerta geral se preferir.
            // let alert = UIAlertController(title: "Erro de Registro", message: "Por favor, corrija os campos destacados.", preferredStyle: .alert)
            // alert.addAction(UIAlertAction(title: "OK", style: .default))
            // present(alert, animated: true)
        }
    }
}

#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    RegisterViewController()
})
#endif
