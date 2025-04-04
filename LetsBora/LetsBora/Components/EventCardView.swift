//
//  EventCardView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class EventCardView: UIView {
    // MARK - UI Properties
    private let noImageCardHeight: CGFloat = 135
    private let imageHeight: CGFloat = 140
    
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(labelType: .h3,colorStyle: .black)
    private lazy var locationLabel = ReusableLabel(labelType: .h6, colorStyle: .tertiary)
    private lazy var tagView: TagView = TagView(text: "Private")
    private lazy var dateLabel = ReusableLabel(labelType: .caption, colorStyle: .black)
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
        view.height(constant: noImageCardHeight)
        
        return view
    }()
    
    private lazy var cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor  = .white
        stackView.layer.cornerRadius = 24
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.25
        stackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        stackView.layer.shadowRadius = 4
        stackView.spacing = 0
        return stackView
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
    // MARK: - Layout
       override func layoutSubviews() {
           super.layoutSubviews()
           cardStackView.layer.shadowPath = UIBezierPath(roundedRect: cardStackView.bounds, cornerRadius: 24).cgPath
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
    public func setTagViewTextColor(text: String,
                                    textColor: UIColor = .white, backgroundColor: UIColor = .black
    ) -> EventCardView {
        self.tagView.setText(text)
        self.tagView.setTextColor(textColor)
        self.tagView.setBackgroundColor(backgroundColor)
        return self
    }
    public func setAvatars(_ avatars: [String], _ extraCount: Int = 0) -> EventCardView {
        self.avatarGroupView.setAvatars(avatars)
        self.avatarGroupView.setExtraCount(extraCount)
        return self
    }
    public func setImage(_ name: String) -> EventCardView {
        self.cardImageView.image = UIImage(named: name)
        self.cardImageView.height(constant: imageHeight)
        
        if !cardStackView.arrangedSubviews.contains(cardImageView) {
            cardStackView.insertArrangedSubview(cardImageView, at: 0)
        }
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
        
        cardStackView.addArrangedSubview(cardView)
        
        self.addSubview(cardStackView)
    }
    
    func setConstraints() {
        tagView
            .top(anchor: tagDateLabelView.topAnchor)
            .leading(anchor: tagDateLabelView.leadingAnchor)
            
        
        dateLabel
            .centerY(tagView.centerYAnchor)
            .leading(anchor: tagView.trailingAnchor,constant: 8)
        
        tagDateLabelView
            .height(anchor: tagView.heightAnchor, constant: 1)
            
        stackView
            .top(anchor: cardView.topAnchor, constant: 10)
            .leading(anchor: cardView.leadingAnchor,constant: 10)
            .bottom(anchor: cardView.bottomAnchor,constant: -10)
        
        detailButton
            .bottom(anchor: cardView.bottomAnchor, constant: -10)
            .trailing(anchor: cardView.trailingAnchor, constant: -10)
        
        cardStackView
            .setContraintsToParent(self)
    }
    
    
}
// MARK: - Preview
@available(iOS 17.0, *)
#Preview("Event Card View", traits: .sizeThatFitsLayout, body: {
    let cell1 = EventCardView()
        .setTitleLabel("Aniversário do João")
        .setTagViewTextColor(text: "Partiular")
        .setDateLabel("May 15, 2025")
        .setLocationLabel("Casa do  João")
        .setAvatars(["Junior","Marcos","Ana"],2)
    
    let cell2 = EventCardView()
        .setTitleLabel("Evento Teste 2")
        .setDateLabel("May 15, 2025")
        .setLocationLabel("Local de Teste")
        .setAvatars(["Junior","Marcos","Ana"],5)
        .setImage("imageCard2")
    
    let cell3 = EventCardView()
        .setTitleLabel("Festival de Verão 2025")
        .setDateLabel("25 Marc")
        .setLocationLabel("Arena Show - São Paulo,SP")
        .setTagViewTextColor(text: "Show", textColor: .white, backgroundColor: .systemPurple)
        .setDetailButtonTitle("Participar")
        .setAvatars(["John","Julia","Jim"],25)
        .setImage("imageCard1")
    
    
    let cells = [
        cell1,
        cell2,
        cell3,
    ]
    
    let stackView = UIStackView(arrangedSubviews: cells)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    return stackView
})
