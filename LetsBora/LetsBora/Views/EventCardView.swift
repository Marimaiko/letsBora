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
    private let dateLabel: UILabel
    
    init(title: String, location: String, tag: String, date:String) {
        self.titleLabel = UILabel()
        self.locationLabel = UILabel()
        self.tagView = TagView(text: tag)
        self.dateLabel  = UILabel()
        super.init(frame: .zero)
        setupUI(title: title, location:location, date: date)
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(title: String, location: String, date:String) {
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
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        // Configure location label
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = location
        locationLabel.font = .systemFont(ofSize: 16, weight: .light)
        locationLabel.textColor = .darkGray
        
        // Configure date label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = date
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        // configure the Button
        
        let tagDateStackView: UIStackView = UIStackView(arrangedSubviews: [tagView,dateLabel])
        tagDateStackView.translatesAutoresizingMaskIntoConstraints = false
        tagDateStackView.axis = .horizontal
        tagDateStackView.spacing = 4
        tagDateStackView.distribution = .fill
        
        let stackView = UIStackView(
            arrangedSubviews:[ tagDateStackView, titleLabel, locationLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            tagDateStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
}
@available(iOS 17.0, *)
#Preview("Event Card View",traits: .fixedLayout(width: 200, height: 130)) {
    EventCardView(title: "Sample Card", location: "Sample Location", tag: "Private",date: "15 Marc")
}
