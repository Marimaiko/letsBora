//
//  SearchView.swift
//  LetsBora
//
//  Created by Davi Paiva on 11/04/25.
//

import UIKit

class SearchView: UIView {
    
    lazy var labelTitle = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search View"
        return label
    }()
    
    // MARK: - LifeCycle
    init(){
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension SearchView {
    func setupView(){
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        self.addSubview(labelTitle)
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                            constant: 8),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    SearchView()
})
