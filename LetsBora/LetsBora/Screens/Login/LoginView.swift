//
//  LoginView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 21/03/25.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapLoginButton()
    func didTapCreateAccount()
    func didTapForgetPassword()
}
class LoginView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    weak var delegate: LoginViewDelegate?
    
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
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pronto para seu\npróximo rolê?"
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
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
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Senha"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
    
    lazy private var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .white
        button.setTitleColor(UIColor(hex: "#7B61FF"), for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var dividerLeft: DividerView = {
        let divider = DividerView(height: 1, color: .white)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    lazy private var dividerRight: DividerView = {
        let divider = DividerView(height: 1, color: .white)
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    lazy private var orLabel: UILabel = {
        let label = UILabel()
        label.text = "ou"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var dividerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dividerLeft, orLabel, dividerRight])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy private var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Esqueceu \na senha?", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapForgetPassword), for: .touchUpInside)
        return button
    }()
    
    lazy private var newAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Não tem conta?\nCrie aqui!", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapNewAccount), for: .touchUpInside)
        return button
    }()
    
    lazy private var linksStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [forgetPasswordButton, newAccountButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func createSocialButton(title: String, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(" \(title)", for: .normal)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }
    
    lazy private var appleButton = createSocialButton(title: "Entre com Apple", imageName: "apple.logo")
    lazy private var googleButton = createSocialButton(title: "Entre com Google", imageName: "g.circle")
    lazy private var facebookButton = createSocialButton(title: "Entre com Facebook", imageName: "f.circle")
    
    lazy private var socialButtonsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                //appleButton,
                googleButton,
                facebookButton
            ])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        buildView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Métodos para exibir/ocultar erros
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

    func resetErrorMessages() {
        displayEmailError(nil)
        displayPasswordError(nil)
    }
}

extension LoginView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.superlayer == nil { // Adiciona o gradiente apenas uma vez
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
        scrollView.addSubview(titleLabel)
       
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(emailErrorLabel)
        
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordErrorLabel)
        
        scrollView.addSubview(loginButton)
        scrollView.addSubview(dividerStackView)
        scrollView.addSubview(linksStackView)
        scrollView.addSubview(socialButtonsStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 28),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
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

            loginButton.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 28),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            linksStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            linksStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            linksStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            dividerStackView.topAnchor.constraint(equalTo: linksStackView.bottomAnchor, constant: 20),
            dividerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            dividerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            dividerLeft.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            dividerRight.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            socialButtonsStackView.topAnchor.constraint(equalTo: dividerStackView.bottomAnchor, constant: 20),
            socialButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            socialButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            socialButtonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),    
        ])
    }
    // temporary function for testing only
    @objc func loginButtonTapped() {
        delegate?.didTapLoginButton()
    }
    
    @objc private func didTapNewAccount() {
        delegate?.didTapCreateAccount()
        print("clicou em Criar conta")
    }
    
    @objc private func didTapForgetPassword() {
        delegate?.didTapForgetPassword()
        print("clicou em Esqueceu senha")
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
