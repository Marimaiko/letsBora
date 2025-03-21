//
//  ProfileEditViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    // MARK: - UI Components
    
    /// Label that displays "Nome" (Name) above the text field
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium) // Set medium weight system font
        label.text = "Nome" // Set label text
        label.textColor = .black // Set text color
        
        return label
    }()
    
    /// Text field for user to input their name
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        textField.borderStyle = .roundedRect // Add rounded border to text field
        // Set fixed height of 40 points
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()
    
    /// Stack view that contains the name label and text field
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[nameLabel,nameTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false // Disable autoresizing mask
        stackView.distribution = .fill // Use natural sizes of arranged views
        stackView.axis = .vertical // Arrange views vertically
        stackView.spacing = 8 // Set spacing between arranged views
        
        return stackView
    }()
    
    // MARK: - LifeCycle
    
    /// Called after the view controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set light gray background color
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
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
        view.addSubview(stackView)
    }
    
    /// Sets up Auto Layout constraints for the stack view
    private func setConstraints(){
        let constraints: [NSLayoutConstraint] = [
            // Position stack view at the top of safe area with 16pt horizontal margins
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditViewController()
})
