//
//  ProfileView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 31/03/25.
//
import UIKit

class ProfileView: UIView {
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Perfil"
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var profileInfo: ProfileInfoView = {
        let view = ProfileInfoView()
        view.config(
            name: "Julia",
            email: "julia@example.com",
            image: UIImage(named: "profile-photo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var numberTitleLabel: QuantityTitleView = {
        let view = QuantityTitleView()
        view.config(number: "24", title: "Eventos")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var conquerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Conquistas"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var conquestExpert = ConquestIconView(type: .expert)
    lazy private var conquestTopHost = ConquestIconView(type: .topHost)
    lazy private var conquestPopular = ConquestIconView(type: .popular)
    
    lazy private var conquestStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [conquestExpert, conquestTopHost, conquestPopular])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
//MARK: Init
    init() {
        super.init(frame: .zero)
        configView()
        buildViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    func configView() {
        backgroundColor = UIColor(hex: "#F2F2F7")
    }
    
    func buildViews() {
        addSubview(titleLabel)
        addSubview(profileInfo)
        addSubview(numberTitleLabel)
        addSubview(conquerTitleLabel)
        addSubview(conquestStack)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 80),
            
            profileInfo.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            profileInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            numberTitleLabel.leadingAnchor.constraint(equalTo: profileInfo.trailingAnchor, constant: 24),
            numberTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            numberTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            conquerTitleLabel.topAnchor.constraint(equalTo: profileInfo.bottomAnchor, constant: 24),
            conquerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            conquestStack.topAnchor.constraint(equalTo: conquerTitleLabel.bottomAnchor, constant: 16),
            conquestStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            conquestStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
