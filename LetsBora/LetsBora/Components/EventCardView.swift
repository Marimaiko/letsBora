//
//  EventCardView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class EventCardView: UIView {
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(labelType: .H3,colorStyle: .black)
    private lazy var locationLabel = ReusableLabel(labelType: .H6, colorStyle: .tertiary)
    private lazy var tagView: TagView = TagView(text: "Private")
    private lazy var dateLabel = ReusableLabel(labelType: .caption, colorStyle: .black)
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "Ver Detalhes"
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
        
        view.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Configuration
    public func setTitleLabel(_ title: String) -> EventCardView {
        self.titleLabel.text = title
        return self
    }
    public func setLocationLabel(_ location: String) -> EventCardView {
        self.locationLabel.text = location
        return self
    }
    public func setDateLabel(_ date: String) -> EventCardView {
        self.dateLabel.text = date
        return self
    }
    public func setDetailButtonTitle(_ title: String) -> EventCardView {
        self.detailButton.configuration?.title = title
        return self
    }
    public func setTagViewText(_ text: String) -> EventCardView {
        self.tagView.setText(text)
        return self
    }
    public func setAvatars(_ avatars: [String], _ extraCount: Int = 0) -> EventCardView {
        self.avatarGroupView.setAvatars(avatars)
        self.avatarGroupView.setExtraCount(extraCount)
        return self
    }
  
}

// MARK: - ViewCode Extension
extension EventCardView: ViewCode {
    func setHierarchy() {
        tagDateLabelView.addSubview(tagView)
        tagDateLabelView.addSubview(dateLabel)
        
        stackView.addArrangedSubview(tagDateLabelView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(avatarGroupView)
        
        cardView.addSubview(detailButton)
        cardView.addSubview(stackView)
        
        self.addSubview(cardView)
    }
    
    func setConstraints() {
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
// MARK: - Preview
@available(iOS 17.0, *)
#Preview("Event Card View", traits: .fixedLayout(width: 400, height: 500), body: {
    
    EventCardView()
        .setTitleLabel("Evento Teste")
        .setDateLabel("15 May")
        .setLocationLabel("Local de Teste")
        .setAvatars(["Junior","Marcos","Ana"],2)
        
    
})
