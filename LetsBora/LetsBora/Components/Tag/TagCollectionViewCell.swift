//
//  TagCollectionViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 24/04/25.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    // identifier for reuse
    static let identifier: String = String(describing: TagCollectionViewCell.self)
    
    // MARK: - UI Component
    private lazy var tagElement: TagView = TagView(text: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(with tag: Tag){
        tagElement.setText(tag.title)
        tagElement.setTextColor(tag.color)
        tagElement.setBackgroundColor(tag.bgColor)
    }
    
}
extension TagCollectionViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(tagElement)
    }
    
    func setConstraints() {
        tagElement
            .centerX(contentView.centerXAnchor)
            .centerY(contentView.centerYAnchor)
        
    }
    
    
}
