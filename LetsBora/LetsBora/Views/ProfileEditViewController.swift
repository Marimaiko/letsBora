//
//  ProfileEditViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    // MARK: - UI Components
    
    /// Name component
    private lazy var nameLabel: UILabel = createLabel(withText: "Nome")
    private lazy var nameTextField: UITextField = createTextField()
    lazy var stackView: UIStackView = createStackView(arrangedSubviews: [nameLabel, nameTextField])
    
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
    
    // MARK: - Factory Components
    /// Function to factory labels with diferent texts
    /// - Parameter text: text to Label
    /// - Returns: return a UILabel componet
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }
    
    private func createTextField(height: CGFloat = 40) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: height).isActive = true
        return textField
    }
    
    private func createStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }
    
}



// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditViewController().stackView
})
