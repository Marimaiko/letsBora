//
//  ProgressBar.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/05/25.
//

import UIKit

import UIKit

class ProgressBar: UIView {
    private let trackView = UIView()
    private let tintView = UIView()
    
    var isActiveComponent: Bool = true {
        didSet {
            updateColor()
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupView()
        configView()
    }
    
    private func configView() {
        trackView.translatesAutoresizingMaskIntoConstraints = false
        tintView.translatesAutoresizingMaskIntoConstraints = false
        
        trackView.backgroundColor = .gray.withAlphaComponent(0.5)
        tintView.backgroundColor = .blue.withAlphaComponent(0.5)
        
        trackView.layer.cornerRadius = 8
        tintView.layer.cornerRadius = 8
    }
    private func updateColor(){
        if(isActiveComponent){
            trackView.backgroundColor = .blue.withAlphaComponent(0.2)
            tintView.backgroundColor = .blue.withAlphaComponent(0.5)
        }else{
            trackView.backgroundColor = .systemGray2.withAlphaComponent(0.3)
            tintView.backgroundColor = .systemGray2.withAlphaComponent(0.5)
        }
            
    }
    
    
}

extension ProgressBar: ViewCode {
    func setHierarchy() {
        addSubview(trackView)
        addSubview(tintView)
    }
    
    func setConstraints() {
        trackView
            .top(anchor: topAnchor)
            .leading(anchor: leadingAnchor)
            .trailing(anchor: trailingAnchor)
            .bottom(anchor: bottomAnchor)
        
        tintView
            .top(anchor: trackView.topAnchor)
            .bottom(anchor: trackView.bottomAnchor)
            .leading(anchor: trackView.leadingAnchor)
            .width(to: trackView.widthAnchor, multiplier: 0.3)
        
    }
}

@available(iOS 17.0, *)
#Preview("ProgressBar", traits: .fixedLayout(width: 300, height: 20)) {
    let pb = ProgressBar()
    pb.isActiveComponent = false
    return pb
}

