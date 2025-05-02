//
//  Extension+Constraints.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/05/25.
//
import UIKit
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.firstItem!,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: self.constant
        )
    }
}
