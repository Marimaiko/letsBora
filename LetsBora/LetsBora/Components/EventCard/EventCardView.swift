//
//  EventCardView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

protocol EventCardViewDelegate: AnyObject {
    func didTapDetailButton(in view: EventCardView)
}

class EventCardView: UIView {
    weak var delegate: EventCardViewDelegate?
    
    // MARK: - UI Properties
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
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
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
    public func setTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    public func setLocationLabel(_ location: String) {
        self.locationLabel.text = location
    }
    public func setDateLabel(_ date: String) {
        self.dateLabel.text = date
    }
    public func setDetailButtonTitle(_ title: String)  {
        self.detailButton.configuration?.title = title
    }
    public func setTagViewTextColor(
        text: String,
        textColor: UIColor = .white,
        backgroundColor: UIColor = .black
    ){
        self.tagView.setText(text)
        self.tagView.setTextColor(textColor)
        self.tagView.setBackgroundColor(backgroundColor)
    }
    public func setAvatars(_ avatars: [String], _ extraCount: Int = 0) {
        self.avatarGroupView.setAvatars(avatars)
        self.avatarGroupView.setExtraCount(extraCount)
    }
    public func setImage(_ name: String){
        self.cardImageView.image = UIImage(named: name)
        self.cardImageView.height(constant: imageHeight)
        
        if !cardStackView.arrangedSubviews.contains(cardImageView) {
            cardStackView.insertArrangedSubview(cardImageView, at: 0)
        }
        
    }
    @objc private func detailButtonTapped() {
        delegate?.didTapDetailButton(in: self)
    }
}

// MARK: - ViewCode Extension
extension EventCardView: ViewCode {
    func setHierarchy() {
        self.addSubview(cardStackView)
        
        tagDateLabelView.addSubview(tagView)
        tagDateLabelView.addSubview(dateLabel)
        
        cardStackView.addArrangedSubview(cardView)
        
        cardView.addSubview(detailButton)
        cardView.addSubview(stackView)
        
        stackView.addArrangedSubview(tagDateLabelView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(avatarGroupView)
        
    }
    
    func setConstraints() {
        cardStackView
            .setContraintsToParent(self)
        
        detailButton
            .bottom(anchor: cardView.bottomAnchor, constant: -10)
            .trailing(anchor: cardView.trailingAnchor, constant: -10)
        
        stackView
            .top(anchor: cardView.topAnchor, constant: 10)
            .leading(anchor: cardView.leadingAnchor,constant: 10)
            .bottom(anchor: cardView.bottomAnchor,constant: -10)
        
        tagView
            .top(anchor: tagDateLabelView.topAnchor)
            .leading(anchor: tagDateLabelView.leadingAnchor)
        
        dateLabel
            .centerY(tagView.centerYAnchor)
            .leading(anchor: tagView.trailingAnchor,constant: 8)
        
        tagDateLabelView
            .height(anchor: tagView.heightAnchor, constant: 1)
    }
    
    
}
// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Event Card View", traits: .sizeThatFitsLayout, body: {
    let cell1 = EventCardView()
    cell1.setTitleLabel("Aniversário do João")
    cell1.setTagViewTextColor(text: "Partiular")
    cell1.setDateLabel("May 15, 2025")
    cell1.setLocationLabel("Casa do  João")
    cell1.setAvatars(["Junior","Marcos","Ana"],2)
    
    let cell2 = EventCardView()
    cell2.setTitleLabel("Evento Teste 2")
    cell2.setDateLabel("May 15, 2025")
    cell2.setLocationLabel("Local de Teste")
    cell2.setAvatars(["Junior","Marcos","Ana"],5)
    cell2.setImage("imageCard2")
    
    let cell3 = EventCardView()
    cell3.setTitleLabel("Festival de Verão 2025")
    cell3.setDateLabel("25 Marc")
    cell3.setLocationLabel("Arena Show - São Paulo,SP")
    cell3.setTagViewTextColor(text: "Show", textColor: .white, backgroundColor: .systemPurple)
    cell3.setDetailButtonTitle("Participar")
    cell3.setAvatars(["John","Julia","Jim"],25)
    cell3.setImage("imageCard1")
    
    
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
#endif
