//
//  UIView+Constraints.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//
import UIKit

extension UIView {
    @discardableResult
    func top(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,constant: CGFloat = 0) -> UIView {
        let constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return self
    }
    @discardableResult
    func bottom(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,constant: CGFloat = 0) -> UIView {
        let constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return self
    }
    @discardableResult
    func leading(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,constant: CGFloat = 0) -> UIView {
        let constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return self
    }
    @discardableResult
    func trailing(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,constant: CGFloat = 0) -> UIView {
        let constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return self
    }
    @discardableResult
    func centerY(_ centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>,constant: CGFloat = 0) -> UIView {
        let constraint = centerYAnchor.constraint(equalTo: centerY, constant: constant)
        constraint.isActive = true
        return self
    }
    @discardableResult
    func centerX(_ centerX: NSLayoutAnchor<NSLayoutXAxisAnchor>,constant: CGFloat = 0) -> UIView {
        let constraint = centerXAnchor.constraint(equalTo: centerX, constant: constant)
        constraint.isActive = true
        return self
    }
    @discardableResult
    func height(id: String? = nil, constant: CGFloat) -> UIView {
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        constraint.identifier = id
        return self
    }
    @discardableResult
    func width(id: String? = nil, constant: CGFloat) -> UIView {
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        constraint.identifier = id
        return self
    }
    @discardableResult
    func width(id: String? = nil, anchor: NSLayoutAnchor<NSLayoutDimension>) -> UIView {
        let constraint = widthAnchor.constraint(equalTo: anchor)
        constraint.isActive = true
        constraint.identifier = id
        return self
    }
    
    func setContraintsToParent(_ parent: UIView){
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.topAnchor),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
        ])
    }
}
