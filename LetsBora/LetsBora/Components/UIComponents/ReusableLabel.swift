//
//  ReusableUILabel.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//

import UIKit

final class ReusableLabel: UILabel {
    enum PresetType{
        case errorLabel
    }
    enum LabelType {
        case h1, h2, h3, h4, h5, h6
        case title, body, caption, captionRegular, subCaption
    }
    
    enum ColorStyle {
        case primary, secondary, tertiary
        case black, white
        case gray1, gray2, gray3
        case error
    }

    // MARK: - Initializer
    init(preset: PresetType){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        switch preset {
        case .errorLabel:
            self.text = ""
            self.isHidden = true
            setColor(for: .error)
            setFont(for: .subCaption)
        }
        
    }
    
    
    init(
        text: String? = nil,
        labelType: LabelType = .body,
        colorStyle: ColorStyle = .black,
        isHidden: Bool = false
    ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.isHidden = isHidden
        setFont(for: labelType)
        setColor(for: colorStyle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func updateText(_ text: String?) {
        self.text = text ?? ""
    }

    // MARK: - Private Methods
    private func setFont(for type: LabelType) {
        let sizeWeight: (CGFloat, UIFont.Weight)
        switch type {
        case .h1:              sizeWeight = (34, .bold)
        case .h2:              sizeWeight = (24, .regular)
        case .h3:              sizeWeight = (20, .bold)
        case .h4:              sizeWeight = (17, .bold)
        case .h5:              sizeWeight = (16, .medium)
        case .h6:              sizeWeight = (16, .light)
        case .body:            sizeWeight = (18, .regular)
        case .caption:         sizeWeight = (14, .semibold)
        case .captionRegular:  sizeWeight = (14, .regular)
        case .subCaption:      sizeWeight = (12, .semibold)
        case .title:           sizeWeight = (48, .regular)
        }
        self.font = .systemFont(ofSize: sizeWeight.0, weight: sizeWeight.1)
    }

    private func setColor(for style: ColorStyle) {
        switch style {
        case .primary:   textColor = .systemBlue
        case .secondary: textColor = .systemGray
        case .tertiary:  textColor = .darkGray
        case .black:     textColor = .black
        case .white:     textColor = .white
        case .gray1:     textColor = .systemGray
        case .gray2:     textColor = .systemGray2
        case .gray3:     textColor = .systemGray3
        case .error:     textColor = .systemRed
        }
    }
}
