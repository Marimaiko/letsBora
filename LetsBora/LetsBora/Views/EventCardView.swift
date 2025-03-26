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
    private let detailButton: UIButton
    
    init(title: String, location: String, tag: String, date:String, buttonTitle: String = "Ver detalhes") {
        self.titleLabel = UILabel()
        self.locationLabel = UILabel()
        self.tagView = TagView(text: tag)
        self.dateLabel  = UILabel()
        self.detailButton = UIButton(type: .system)
        
        super.init(frame: .zero)
        setupUI(title: title, location:location, date: date, button: buttonTitle)
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(title: String, location: String, date:String, button: String) {
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
        var config = UIButton.Configuration.filled()
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        config.title = button
        detailButton.configuration = config
        
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
        
        addSubview(detailButton)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            tagDateStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            detailButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            detailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
        ])
    }
    
}

@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    EventCardView(title: "Titulo de teste", location: "Local de  Teste", tag: "Tag de Teste", date: "15 05 2021", buttonTitle: "Ver  detalhes")
})
