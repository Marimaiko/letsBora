//
//  ReusableTextField.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//

import UIKit

final class ReusableTextField: UITextField {
    
    enum FieldStyle {
        case standard
        // Add more styles if needed (e.g., `roundedBorder`, `underlined`, etc.)
    }

    // MARK: - Initializer
    init(
        placeholder: String? = nil,
        style: FieldStyle = .standard,
        textColor: UIColor = .black,
        height: CGFloat = 48
    ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.textColor = textColor
        applyStyle(style)
        setHeightConstraint(height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Setup
    private func applyStyle(_ style: FieldStyle) {
        switch style {
        case .standard:
            borderStyle = .roundedRect
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }

    private func setHeightConstraint(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
