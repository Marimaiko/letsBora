//
//  AvatarGroupView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class AvatarGroupView: UIView {
    // MARK: - Properties
    private let maxVisibleAvatars: Int = 3
    
    // MARK: - UI Components
    private let stackView:  UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    init(avatars: [String], extraCount: Int = 0) {
        super.init(frame: .zero)
        setupView()
        configure(with: avatars, extraCount: extraCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - SetupView
    private func setupView() {
        addSubview(stackView)
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
        ])
    }
    private func configure(with avatars: [String], extraCount: Int) {
        for avatar in avatars.prefix(maxVisibleAvatars) {
            let image: UIImage = UIImage(named: avatar) ?? UIImage(systemName: "person.circle")   ?? UIImage()
            let avatarView = AvatarImageView(with: image)
            stackView.addArrangedSubview(avatarView)
        }
        
        if extraCount > 0 {
            // TODO: use +10 leading pad
            countLabel.text = "+\(extraCount)"
            stackView.addArrangedSubview(countLabel)
            
        }
    }
    
}

@available(iOS 17.0, *)
#Preview("AvatarGroup", traits: .sizeThatFitsLayout){
    let avatars: [String] = ["Jim", "Julia", "John"]
    let avatars2: [String] = ["Jim", "Julia"]
    let avatars3: [String] = ["Jim", "Julia","tobison"]
    let cells = [
        AvatarGroupView(avatars: avatars, extraCount: 2),
        AvatarGroupView(avatars: avatars),
        AvatarGroupView(avatars: avatars2),
        AvatarGroupView(avatars: avatars2, extraCount:10),
        AvatarGroupView(avatars: avatars3, extraCount:1),        
    ]
    
    let stackView = UIStackView(arrangedSubviews: cells)
    stackView.axis = .vertical
    stackView.spacing = 50
    
    return stackView
    
}

