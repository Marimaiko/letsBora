//
//  TagView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class TagView: UIView {
    // MARK: - UI Properties
    private let tagHeight: CGFloat = 24
    private let tagWidthRelativeToLabel: CGFloat = 24
    
    // MARK: - UI Components
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    private lazy var tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
    
        return view
    }()
    
    
    // MARK: - Init
    init(text: String = "") {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        text != "" ? setText(text) : ()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Configuration
    public func setText(_ text: String) {
        label.text = text
    }
    public func setTextColor(_ color: UIColor) {
        label.textColor = color
    }
    public func setBackgroundColor(_ color: UIColor) {
        tagView.backgroundColor = color
    }
}

// MARK: - ViewCode Extension
extension TagView: ViewCode {
    func setHierarchy(){
        self.addSubview(tagView)
        tagView.addSubview(label)
    }
    
    func setConstraints() {
        label
            .centerX(tagView.centerXAnchor)
            .centerY(tagView.centerYAnchor)
        
        tagView
            .height(constant: tagHeight)
            .width(anchor: label.widthAnchor,constant: tagWidthRelativeToLabel)
            .setContraintsToParent(self)
    }
}
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Tag View", traits: .sizeThatFitsLayout) {
    let tag = TagView()
    tag.setText("Sample")
    
    return tag
                
}
#endif
