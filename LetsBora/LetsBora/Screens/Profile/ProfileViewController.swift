//
//  ProfileViewModel.swift
//  LetsBora
//
//  Created by Mariana Maiko on 09/04/25.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let profileView = ProfileView()
        self.view = profileView
    }
}


// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileViewController()
})
