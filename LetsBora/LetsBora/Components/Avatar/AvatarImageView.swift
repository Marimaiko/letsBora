//
//  AvatarImageView.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/03/25.
//

import UIKit

class AvatarImageView: UIImageView {
    // MARK: - Initializer
    init(
        with image: UIImage = UIImage(systemName: "person.circle") ?? UIImage(),
        size: CGFloat = 30,
        borderWidth: CGFloat = 2
    ){
        super.init(frame: .zero)
        self.image = image
        setupImageView(size: size,borderWidth: borderWidth)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup ImageView
    func setImage(named: String){
        self.image = UIImage(named: named) ??
        UIImage(systemName: "person.circle") ??
        UIImage()
    }
    private func setupImageView(
        size: CGFloat,
        borderWidth: CGFloat
    ) {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = size/2  // Circular shape
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }
}

@available(iOS 17.0, *)
#Preview("AvatarImageView", traits: .sizeThatFitsLayout){    
    AvatarImageView()
    
}
