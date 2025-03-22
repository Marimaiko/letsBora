//
//  EventCardView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class EventCardView: UIView {
    private let titleLabel: UILabel
    private let locationLabel: UILabel
    private let tagView: TagView
    
    init(title: String, location: String, tag: String) {
        self.titleLabel = UILabel()
        self.locationLabel = UILabel()
        self.tagView = TagView(text: tag)
        super.init(frame: .zero)
        setupUI(title: title, location:location)
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(title: String, location: String) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        
        // Configure title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        // Configure location label
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = location
        locationLabel.font = .systemFont(ofSize: 14, weight: .light)
        locationLabel.textColor = .darkGray
        
        let stackView = UIStackView(
            arrangedSubviews:[ tagView, titleLabel, locationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
