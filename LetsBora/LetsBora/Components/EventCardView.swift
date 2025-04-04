//
//  EventCardView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class EventCardView: UIView {
    // MARK: - UI Components
    private lazy var titleLabel = ReusableUILabel(labelType: .H3,colorStyle: .black)
    private lazy var locationLabel = ReusableUILabel(labelType: .H6, colorStyle: .tertiary)
    private lazy var tagView: TagView = TagView()
    private lazy var dateLabel = ReusableUILabel(labelType: .caption, colorStyle: .black)
    
    private let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        return button
    }()
    private let avatarGroupView: AvatarGroupView = AvatarGroupView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()
    private lazy var tagDateLabelView: UIView = {
        let stackView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        
        view.heightAnchor.constraint(equalToConstant: 143).isActive = true
        
        return view
    }()
    
    
    
    init(title: String,
         location: String,
         tag: String = "Private",
         date:String,
         avatars: [String] = [],
         extraCountAvatars: Int = 0,
         buttonTitle: String = "Ver detalhes"){
        
        super.init(frame: .zero)
        setupView()
        configure(title: title, location: location, date: date, button: buttonTitle, tag: tag)
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        tagDateLabelView.addSubview(tagView)
        tagDateLabelView.addSubview(dateLabel)
        
        stackView.addArrangedSubview(tagDateLabelView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(avatarGroupView)
        
        cardView.addSubview(detailButton)
        cardView.addSubview(stackView)
        
        addSubview(cardView)
    }
    
    private func configure(title: String, location: String, date:String, button: String, tag: String) {
        // configure self view
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // configure components
        titleLabel.text = title
        locationLabel.text = location
        dateLabel.text = date
        detailButton.configuration?.title = button
        tagView.setText(tag)
        avatarGroupView.setAvatars(["","",""])
        avatarGroupView.setExtraCount(3)
        
        // set constraints
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: tagDateLabelView.topAnchor),
            tagView.leadingAnchor.constraint(equalTo: tagDateLabelView.leadingAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: tagDateLabelView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: tagView.trailingAnchor,constant: 8),
            
            tagDateLabelView.topAnchor.constraint(equalTo: stackView.topAnchor),
            tagDateLabelView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            tagDateLabelView.bottomAnchor.constraint(equalTo: tagView.bottomAnchor,constant: 2),
            
            
            
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            
            detailButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            detailButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
}

@available(iOS 17.0, *)
#Preview("Event Card View", traits: .fixedLayout(width: 400, height: 500), body: {
    
    EventCardView(title: "Titulo de teste",
                  location: "Local de  Teste",
                  tag:"Privado",
                  date: "15 05 2021",
                  avatars: ["Jim", "Julia", "John"],
                  extraCountAvatars: 2,
                  buttonTitle: "Ver  detalhes")
    
})
