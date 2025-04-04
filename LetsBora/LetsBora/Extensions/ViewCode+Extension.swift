//
//  ViewCode+Extension.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//

protocol ViewCode {
    func setHierarchy()
    func setConstraints()
    
    func setupView()
}

extension ViewCode {
    func setupView() {
        setHierarchy()
        setConstraints()
    }
}
