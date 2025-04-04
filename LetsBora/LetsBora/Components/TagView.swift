//
//  TagView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class TagView: UIView {
    
    private let label: UILabel
    private let tagView: UIView
    
    init(text: String = "") {
        self.label = UILabel()
        self.tagView = UIView()
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setText(_ text: String) {
        label.text = text
    }
    private func setupUI(text: String?) {
        // Hierarchy
        tagView.addSubview(label)
        addSubview(tagView)
        
        // configure
        self.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.backgroundColor = .black
        tagView.layer.cornerRadius = 12
        tagView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text ?? ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .center
        
        // constraints
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: tagView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: tagView.centerYAnchor),
            
            tagView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            tagView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            
            tagView.topAnchor.constraint(equalTo: self.topAnchor),
            tagView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tagView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tagView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

@available(iOS 17.0, *)
#Preview("Tag View", traits: .sizeThatFitsLayout) {
    TagView(text: "Sample ")
}
