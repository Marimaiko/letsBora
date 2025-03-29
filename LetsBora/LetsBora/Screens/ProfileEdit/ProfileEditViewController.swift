//
//  ProfileEditViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    // MARK: - UI Components
  private lazy var profileEditView: ProfileEditView = {
        let view = ProfileEditView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    
    /// Sets up the view hierarchy and constraints
    private func setupView(){
        setHierarchy()
        setConstraints()
    }
    
    /// Adds subviews to the view hierarchy
    private func setHierarchy(){
        view.backgroundColor = .white   
        view.addSubview(profileEditView)
    }
    
    /// Sets up Auto Layout constraints for the stack view
    private func setConstraints(){
        let constraints: [NSLayoutConstraint] = [
            // Position stack view at the top of safe area with 16pt horizontal margins
            profileEditView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileEditView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileEditView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileEditView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}



// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditViewController()
})
