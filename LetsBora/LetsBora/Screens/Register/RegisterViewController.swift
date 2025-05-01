//
//  RegisterViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/04/25.
//

import UIKit

class RegisterViewController: UIViewController, RegisterViewDelegate {
    
    override func loadView() {
        let registerView = RegisterView()
        registerView.delegate = self
        self.view = registerView
    }

    func didTapRegister() {
        dismiss(animated: true)
    }
}

@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    RegisterViewController()
})
