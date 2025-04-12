//
//  SearchView.swift
//  LetsBora
//
//  Created by Davi Paiva on 11/04/25.
//

import UIKit

class SearchView: UIView {
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(text: "Buscar", labelType: .title)
    
    // MARK: - LifeCycle
    init(){
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View code setup
extension SearchView: ViewCode {
    func setHierarchy() {
        self.addSubview(titleLabel)
    }
    
    func setConstraints() {
        titleLabel
            .top(anchor: self.topAnchor, constant: 48)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    SearchView()
})
