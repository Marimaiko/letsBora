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
    
    func signUp() async throws {
        let authResult = try await Auth.auth().createUser(withEmail: "davi@davi.com.br", password: "password")
        print("authResult = \(authResult.user)")
        
        let user: User = .init(
            id: authResult.user.uid,
            name: "Davi",
            email: "davi@davi.com.br",
            
        )
        
        do {
            try await Firestore
                .firestore()
                .collection("users")
                .document(authResult.user.uid)
                .setData([
                    "name": "David",
                    "email": "davi@davi.com.br",
                    "createdAt": Date()
                ])
            print("Document successfully written!")
        }   catch {
            print("Error writing document: \(error)")
          }
        
    }
 @objc func backButtonTapped() {
     navigationController?.popViewController(animated: true)
    }
    func didTapRegister() {
        
        guard let nameTextField = registerView?.nameTextField.text,
              let emailTextField = registerView?.nameTextField.text,
              let passwordTextField = registerView?.nameTextField.text else {
            return
        }
        
        if nameTextField.isEmpty || emailTextField.isEmpty || passwordTextField.isEmpty {
            print("Empty Fields")
            return
        }
        
        let user = User(name: nameTextField, email: emailTextField, password: passwordTextField)
        Task {
            await viewModel?.saveUser(user: user)
            await viewModel?.fetchUsers()
            print("Users: \(viewModel?.users ?? [])")
        }
        
        Task {
            do {
                try await self.signUp()
            } catch {
               print(error)
            }
        }
            
            
    }
}

#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    RegisterViewController()
})
#endif
