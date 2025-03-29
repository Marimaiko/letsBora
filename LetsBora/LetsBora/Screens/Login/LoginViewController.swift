//
//  LoginViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 26/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let loginView = LoginView()
        self.view = loginView
    }
}
