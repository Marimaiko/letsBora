//
//  DividerView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 26/03/25.
//

import UIKit

class DividerView: UIView {
    
    init(height: CGFloat = 1, color: UIColor = .lightGray) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
