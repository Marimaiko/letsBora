//
//  ReusableUILabel.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//

import UIKit

class ReusableUILabel: UILabel {
    
    enum labelTypeEnum {
        case H1
        case H2
        case H3
        case H4
        case H5
        case H6
        case body
        case caption
    }
    enum colorStyleEnum {
        case primary
        case secondary
        case tertiary
        case black
        case gray1
        case gray2
        case gray3
        case white
    }
    
    private var labelText: String?
    private var labelType: labelTypeEnum?
    private var colorStyle: colorStyleEnum?
    
    init(labelText: String? = nil, labelType: labelTypeEnum? = nil, colorStyle: colorStyleEnum? = nil) {
        self.labelText = labelText
        self.labelType = labelType
        self.colorStyle = colorStyle
        
        super.init(frame: .zero)
        self.configureLabelColor()
        self.configureLabelStyle()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedText = NSMutableAttributedString(string: self.labelText ?? "Label")
    }
    required init?(coder:NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
}
extension ReusableUILabel {
    private func configureLabelColor() {
        let colorStyle: colorStyleEnum = self.colorStyle ?? .primary
        
        switch colorStyle {
        case .primary:
            self.textColor = .systemBlue
        case .secondary:
            self.textColor = .systemGray
        case.tertiary:
            self.textColor = .darkGray
        case.black:
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
    
    private func configureLabelStyle() {
        let labelType: labelTypeEnum = self.labelType ?? .body
        switch labelType {
        case .body:
            self.font = .systemFont(ofSize: 17)
        case .H1:
            self.font = .systemFont(ofSize: 34, weight: .bold)
        case .H2:
            self.font = .systemFont(ofSize: 24, weight: .bold)
        case .H3:
            self.font = .systemFont(ofSize: 20, weight: .bold)
        case .H4:
            self.font = .systemFont(ofSize: 17, weight: .bold)
        case .H5:
            self.font = .systemFont(ofSize: 16, weight: .medium)
        case .H6:
            self.font = .systemFont(ofSize: 16, weight: .light)
        case .caption:
            self.font = .systemFont(ofSize: 14, weight: .light)
    }
    }
}
