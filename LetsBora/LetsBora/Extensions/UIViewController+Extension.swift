//
//  UIViewController+Extension.swift
//  LetsBora
//
//  Created by Davi  on 24/03/25.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI

extension UIViewController {
    func showPreview() -> some View {
        UIViewControllerPreview {
            self
        }
        .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
#endif

