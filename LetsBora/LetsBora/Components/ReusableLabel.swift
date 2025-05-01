//
//  ReusableUILabel.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//

import UIKit

class ReusableLabel: UILabel {
    
    enum LabelType {
        case h1, h2, h3, h4, h5, h6, body, caption, title
    }
    
    enum ColorStyle {
        case primary, secondary, tertiary, black, gray1, gray2, gray3, white
    }

    init(text: String? = nil,
         labelType: LabelType = .body,
         colorStyle: ColorStyle = .black) {
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        configureFont(for: labelType)
        configureColor(for: colorStyle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setText(_ text: String?) {
        self.text = text ?? ""
    }
    private func configureFont(for type: LabelType) {
        switch type {
        case .h1:
            self.font = .systemFont(ofSize: 34, weight: .bold)
        case .h2:
            self.font = .systemFont(ofSize: 24, weight: .regular)
        case .h3:
            self.font = .systemFont(ofSize: 20, weight: .bold)
        case .h4:
            self.font = .systemFont(ofSize: 17, weight: .bold)
        case .h5:
            self.font = .systemFont(ofSize: 16, weight: .medium)
        case .h6:
            self.font = .systemFont(ofSize: 16, weight: .light)
        case .body:
            self.font = .systemFont(ofSize: 17)
        case .caption:
            self.font = .systemFont(ofSize: 14, weight: .semibold)
        case .title:
            self.font = .systemFont(ofSize: 48, weight: .regular)
        }
    }

    private func configureColor(for style: ColorStyle) {
        switch style {
        case .primary:
            self.textColor = .systemBlue
        case .secondary:
            self.textColor = .systemGray
        case .tertiary:
            self.textColor = .darkGray
        case .black:
            self.textColor = .black
        case .gray1:
            self.textColor = .systemGray
        case .gray2:
            self.textColor = .systemGray2
        case .gray3:
            self.textColor = .systemGray3
        case .white:
            self.textColor = .white
        }
    }
}
