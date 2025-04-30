//
//  ButtonListView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 28/04/25.
//

import UIKit

class SettingsButtonView: UIButton {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabelCustom: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(iconImageName: String, title: String, color: UIColor? = nil) {
        super.init(frame: .zero)
        buildView()
        setupConstraints()
        config(iconImageName: iconImageName, title: title, color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
//        self.addSubview(stackView)
        self.addSubview(iconImageView)
        self.addSubview(titleLabelCustom)
        self.addSubview(chevronImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
                        
            titleLabelCustom.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabelCustom.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 16),
            chevronImageView.heightAnchor.constraint(equalToConstant: 16),
            
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: 320),
            self.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func config(iconImageName: String, title: String, color: UIColor? = nil) {
        iconImageView.image = UIImage(systemName: iconImageName)
        titleLabelCustom.text = title
        backgroundColor = color
        }
}

