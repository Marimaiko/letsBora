//
//  ForgetPasswordView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 22/05/25.
//

import Foundation
import UIKit

protocol ForgetPasswordDelegate: AnyObject {
    func didTapSendEmail()
    func didTapCancel()
}

class ForgetPasswordView: UIView {
    
    weak var delegate: ForgetPasswordDelegate?
    
    lazy private var scrollview: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    lazy private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var tittleLabel: UILabel = {
        let label = UILabel()
        label.text = "LetsBora recuperar sua senha?"
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Insira o e-mail cadastrado"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy private var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Recuperar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .white
        button.setTitleColor(.darkText, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSendEmailButton), for: .touchUpInside)
        return button
    }()
    
    lazy private var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "#7B61FF")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapSendEmailButton() {
        delegate?.didTapSendEmail()
        print("clicou em Recuperar senha")
    }
    
    @objc func didTapCancelButton() {
        delegate?.didTapCancel()
        print("clicou em cancelar")
    }
    func getEmailText() -> String?{
        return emailTextField.text
    }
}

extension ForgetPasswordView: ViewCode{
    func setHierarchy() {
        addSubview(scrollview)
        scrollview.addSubview(contentView)
        
        contentView.addSubview(tittleLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(sendButton)
        contentView.addSubview(cancelButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollview.heightAnchor),
            
            tittleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            tittleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            tittleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            
            emailLabel.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor, constant: 96),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            sendButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 56),
            sendButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -56),
            sendButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -24),
            sendButton.heightAnchor.constraint(equalToConstant: 56),
            
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -64),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}


// MARK: - Preview

@available(iOS 17.0, *)
#Preview("ForgetPasswordView", traits: .portrait, body: {
    
    ForgetPasswordView()
    
})
