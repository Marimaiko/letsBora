//
//  ForgetPasswordViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 22/05/25.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    var screen: ForgetPasswordView?
    
    override func loadView() {
        screen = ForgetPasswordView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate = self
    }
}

extension ForgetPasswordViewController: ForgetPasswordDelegate {
    func didTapSendEmail() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapCancel() {
        navigationController?.popViewController(animated: true)
    }
}
