//
//  AvatarGroupView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class AvatarGroupView: UIView {
    // MARK: - Properties
    private let maxVisibleAvatars: Int
    private let avatarSize: CGFloat
    private let defaultImage: UIImage?
    
    // MARK: - UI Components
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.alignment = .center

        return stackView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    init(
        avatars: [String] = [],
        extraCount: Int = 0,
        maxVisibleAvatars: Int = 3,
        avatarSize: CGFloat = 30,
        defaultImage: UIImage? = UIImage(systemName: "person.circle")
    ) {
        self.maxVisibleAvatars = maxVisibleAvatars
        self.avatarSize = avatarSize
        self.defaultImage = defaultImage
        super.init(frame: .zero)
        
        setupView()
        configure(with: avatars, extraCount: extraCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])
    }
    
    // MARK: - Configuration
    public func configure(with avatars: [String], extraCount: Int) {
        setAvatars(avatars)
        setExtraCount(extraCount)
    }
    
    public func setAvatars(_ avatars: [String]) {
        // Clear existing views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for avatar in avatars.prefix(maxVisibleAvatars) {
            let image: UIImage

            if avatar.isEmpty {
                image = defaultImage ?? UIImage()
            } else {
                image = UIImage(named: avatar) ?? defaultImage ?? UIImage()
            }

            let avatarView = AvatarImageView(with: image, size: avatarSize)
            stackView.addArrangedSubview(avatarView)
        }
    }
    
    public func setExtraCount(_ extraCount: Int) {
        countLabel.isHidden = extraCount <= 0
        countLabel.text = extraCount > 0 ? "+\(extraCount)" : nil
        if extraCount > 0 {
            stackView.addArrangedSubview(countLabel)
        }
    }
}

@available(iOS 17.0, *)
#Preview("AvatarGroup", traits: .sizeThatFitsLayout){
    let avatars: [String] = ["Jim", "Julia", "John"]
    let avatars2: [String] = ["Jim", "Julia"]
    let avatars3: [String] = ["Jim", "Julia","tobison"]
    
    lazy var avatarCell: AvatarGroupView = {
        let avatarGroupView = AvatarGroupView()
        avatarGroupView.setAvatars(["James","Julia"])
        avatarGroupView.setExtraCount(2)
        return avatarGroupView
    }()
    
    let cells = [
        AvatarGroupView(avatars: avatars, extraCount: 2),
        AvatarGroupView(avatars: avatars),
        AvatarGroupView(avatars: avatars2),
        AvatarGroupView(avatars: avatars2, extraCount:10),
        AvatarGroupView(avatars: avatars3, extraCount:1),
        avatarCell
    ]
    
    let stackView = UIStackView(arrangedSubviews: cells)
    stackView.axis = .vertical
    stackView.distribution = .init(rawValue: 2)!
    stackView.spacing = 1
    
    return stackView
    
}

