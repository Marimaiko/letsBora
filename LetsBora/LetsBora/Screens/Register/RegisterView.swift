//
//  RegisterView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/04/25.
//

import UIKit

protocol RegisterViewDelegate: AnyObject {
    func didTapRegister()
    func didTapButtonBack()
}

class RegisterView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    private weak var delegate: RegisterViewDelegate?
    
    func delegate(_ delegate: RegisterViewDelegate){
        self.delegate = delegate
    }
    
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // --- Name ---
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Como podemos te chamar?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .words
        return textField
    }()
    
    lazy var nameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    // --- Email ---
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual seu melhor email?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    // --- Password ---
    private var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual será sua senha?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
        
    // (Opcional) Se quiser "Confirmar Senha", adicionar aqui de forma similar.
    // lazy var confirmPasswordTextField: UITextField = { ... }()
    // lazy var confirmPasswordErrorLabel: UILabel = { ... }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#7B61FF")
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Voltar", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(hex: "#7B61FF"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        buildView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapRegister() {
        delegate?.didTapRegister()
        print("clicou em registrar")
    }
    
    @objc func didTapBackButton(){
        delegate?.didTapButtonBack()
    }
    
    // Métodos para exibir/ocultar erros
    func displayNameError(_ message: String?) {
        nameErrorLabel.text = message
        nameErrorLabel.isHidden = (message == nil)
        nameTextField.layer.borderColor = (message == nil) ? UIColor.clear.cgColor : UIColor.yellow.cgColor
        nameTextField.layer.borderWidth = (message == nil) ? 0 : 1
    }

    func displayEmailError(_ message: String?) {
        emailErrorLabel.text = message
        emailErrorLabel.isHidden = (message == nil)
        emailTextField.layer.borderColor = (message == nil) ? UIColor.clear.cgColor : UIColor.yellow.cgColor
        emailTextField.layer.borderWidth = (message == nil) ? 0 : 1
    }

    func displayPasswordError(_ message: String?) {
        passwordErrorLabel.text = message
        passwordErrorLabel.isHidden = (message == nil)
        passwordTextField.layer.borderColor = (message == nil) ? UIColor.clear.cgColor : UIColor.yellow.cgColor
        passwordTextField.layer.borderWidth = (message == nil) ? 0 : 1
    }
        
    // Se adicionar confirmação de senha
    // func displayConfirmPasswordError(_ message: String?) { ... }

    func resetAllErrorVisuals() {
        displayNameError(nil)
        displayEmailError(nil)
        displayPasswordError(nil)
        // displayConfirmPasswordError(nil) -> Se adicionar confirmação
    }
}

extension RegisterView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.superlayer == nil {
            configView()
        }
        gradientLayer.frame = bounds
    }
    
    func configView() {
        gradientLayer.colors = [
            UIColor(hex: "#7B61FF").cgColor,
            UIColor(hex: "#00D26A").cgColor
        ]
        gradientLayer.locations = [0.0, 0.98]
        gradientLayer.startPoint = CGPoint(x: 0.8, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func buildView() {
        addSubview(scrollView)
        
        scrollView.addSubview(logoImageView)
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(nameErrorLabel)
        
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(emailErrorLabel)
        
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordErrorLabel)
        
        scrollView.addSubview(registerButton)
        scrollView.addSubview(backButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 28),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 36),
            
            nameErrorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 4),
            nameErrorLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            nameErrorLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameErrorLabel.bottomAnchor, constant: 18),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 36),
            
            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 18),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 36),
            
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
                        
            
            registerButton.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 32),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            registerButton.heightAnchor.constraint(equalToConstant: 44),
            
            backButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
        ])
    }
}
