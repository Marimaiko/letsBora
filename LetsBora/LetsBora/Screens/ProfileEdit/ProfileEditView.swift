//
//  ProfileEditView.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/03/25.
//

import UIKit

class ProfileEditView: UIView {
    // MARK: - UI Components
    
    private lazy var nameLabel: UILabel = createLabel(withText: "Nome ")
    private lazy var nameTextField: UITextField = createTextField()
    private lazy var nameStackView: UIStackView = createStackView(subViews: [nameLabel,nameTextField])
    
    private lazy var emailLabel: UILabel = createLabel(withText: "Email")
    private lazy var emailTextField: UITextField = createTextField()
    private lazy var emailStackView: UIStackView = createStackView(subViews: [emailLabel,emailTextField])
    
    private lazy var newPasswordLabel: UILabel = createLabel(withText: "Nova Senha")
    private lazy var newPasswordTextField: UITextField = createTextField()
    private lazy var newPasswordStackView: UIStackView = createStackView(subViews: [newPasswordLabel, newPasswordTextField])
    
    private lazy var confirmPwdLabel: UILabel = createLabel(withText: "Confirmar Senha")
    private lazy var confirmPwdTextField: UITextField = createTextField()
    private lazy var confirmPwdStackView: UIStackView = createStackView(subViews: [confirmPwdLabel,confirmPwdTextField])
    
    private lazy var saveButton: UIButton = createButton(withTitle: "Salvar")
    
    lazy var stackView: UIStackView = createStackView(
        subViews: [ nameStackView,
                    emailStackView,
                    newPasswordStackView,
                    confirmPwdStackView,
                    saveButton],
        spacing: 16)
    
    // MARK: - LifeCycle
    init(){
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup View
    private func setupView() {
        setHierarchy()
        setConstraints()
        // Set light gray background color
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
    }
    /// Adds subviews to the view hierarchy
    private func setHierarchy(){
        addSubview(stackView)
    }
    /// Sets up Auto Layout constraints for the stack view
    private func setConstraints(){
        let constraints: [NSLayoutConstraint] = [
            // Position stack view at the top of safe area with 16pt horizontal margins
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Factory Components
    /// Function to factory labels with different texts
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
    private func createButton(withTitle title: String,height:CGFloat = 50) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return button
    }
    
    private func createStackView(subViews: [UIView], spacing: CGFloat = 8) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing
        return stackView
    }
    
}
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    ProfileEditView()
})
