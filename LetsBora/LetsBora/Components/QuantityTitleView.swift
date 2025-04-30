//
//  QuantityTitle.swift
//  LetsBora
//
//  Created by Mariana Maiko on 14/04/25.
//

import UIKit

class QuantityTitleView: UIView {
//MARK: - Subviews
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [numberLabel, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
//MARK: - Init
    init(number: String, title: String) {
        super.init(frame: .zero)
        buildView()
        setupConstraints()
        config(number: number, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Setup
    private func buildView() {
        addSubview(mainStackView)
            }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
// MARK: - Public Config
    public func config(number: String, title: String) {
        numberLabel.text = number
        titleLabel.text = title
        }
}
