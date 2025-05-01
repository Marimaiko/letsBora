//
//  ProfileEditViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    override func loadView() {
        self.view = ProfileEditView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditViewController()
})
