//
//  ProfileEditViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func loadView() {
        self.view = ProfileEditView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Editar Perfil"
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditViewController()
})
