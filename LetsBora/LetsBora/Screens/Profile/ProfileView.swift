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
    
    private let profileInfo: ProfileInfoView = {
        let view = ProfileInfoView()
        view.configure(
            name: "Julia",
            email: "julia@example.com",
            image: UIImage(named: "profile-photo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 80),
            
            profileInfo.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            profileInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            profileInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 80)
        ])
    }
}
