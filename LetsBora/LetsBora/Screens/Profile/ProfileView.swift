//
//  ProfileView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 31/03/25.
//
import UIKit

protocol ProfileViewDelegate: AnyObject {
    func profileViewDidTapEditButton()
    func exitProfileDidTapButton()
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewDelegate?
    
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
            image: UIImage(named: "Julia"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var numberTitleLabel: QuantityTitleView = {
        let view = QuantityTitleView(number: "24", title: "Eventos")
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
    
    lazy private var configTitle: UILabel = {
        let label = UILabel()
        label.text = "Configurações"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var notificationButton = SettingsButtonView(iconImageName: "bell", title: "Notificações")
    lazy private var privacyButton: SettingsButtonView = SettingsButtonView(iconImageName: "lock", title: "Privacidade")
    lazy private var helpButton = SettingsButtonView(iconImageName: "questionmark.circle", title: "Ajuda e Suporte")

    lazy private var settingButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notificationButton, privacyButton, helpButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy private var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sair", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(exitProfileTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Editar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    @objc func editProfileTapped(){
        self.delegate?.profileViewDidTapEditButton()
    }
    @objc func exitProfileTapped(){
        self.delegate?.exitProfileDidTapButton()
    }
}

extension ProfileView {
    func configView() {
        backgroundColor = UIColor(hex: "#F2F2F7")
    }
    
    func buildViews() {
        addSubview(scrollview)
        scrollview.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(profileInfo)
        contentView.addSubview(numberTitleLabel)
        contentView.addSubview(conquerTitleLabel)
        contentView.addSubview(conquestStack)
        contentView.addSubview(configTitle)
        contentView.addSubview(settingButtonStack)
        contentView.addSubview(exitButton)
        contentView.addSubview(editButton)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 80),
            
            profileInfo.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            profileInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            numberTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            numberTitleLabel.leadingAnchor.constraint(equalTo: profileInfo.trailingAnchor, constant: 24),
            numberTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            conquerTitleLabel.topAnchor.constraint(equalTo: profileInfo.bottomAnchor, constant: 24),
            conquerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            conquestStack.topAnchor.constraint(equalTo: conquerTitleLabel.bottomAnchor, constant: 16),
            conquestStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            conquestStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            configTitle.topAnchor.constraint(equalTo: conquestStack.bottomAnchor, constant: 24),
            configTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            settingButtonStack.topAnchor.constraint(equalTo: configTitle.bottomAnchor, constant: 24),
            settingButtonStack.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 24),
            settingButtonStack.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: -24),

            exitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 100),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -56),
            exitButton.topAnchor.constraint(greaterThanOrEqualTo: settingButtonStack.bottomAnchor, constant: 60),
            
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            editButton.heightAnchor.constraint(equalToConstant: 44),
            editButton.widthAnchor.constraint(equalToConstant: 88),
        ])
    }
}
