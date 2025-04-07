//
//  UIView+Extension.swift
//  LetsBora
//
//  Created by Davi  on 24/03/25.
//

import Foundation
#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI

// MARK: - UIView Preview Extension
extension UIView {
    // Show preview with an option to set custom frame size
    func showPreview(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        UIViewPreview {
            self
        }
        .previewLayout(.sizeThatFits) // Ensures the preview is exactly the view's size
        .padding(0) // Remove any default padding around the view
        .frame(width: width ?? intrinsicContentSize.width,
               height: height ?? intrinsicContentSize.height) // Custom size if provided, otherwise default to intrinsic content size
    }
}

// MARK: - UIViewPreview for SwiftUI
@available(iOS 13.0, *)
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> View {
        view
    }
    
    func updateUIView(_ uiView: View, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
