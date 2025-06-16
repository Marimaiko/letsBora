//
//  EventCardCollectionViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 15/06/25.
//

import UIKit
protocol EventCardViewCellDelegate: AnyObject {
    func didTapDetailButtonInCell(for event: Event)
}
class EventCardCollectionViewCell: UICollectionViewCell {
    // identifier
    static let identifier: String = String(
        describing: EventCardCollectionViewCell.self
    )
    // MARK: - UI Components
    private lazy var eventCard = EventCardView()
    private var currentEvent: Event?
    weak var delegate: EventCardViewCellDelegate?
    
    // MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        eventCard.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Functions
    public func setupCell(
        with event: Event,
        isPastEvent: Bool = false
    ){
        self.currentEvent = event
        eventCard.setTitleLabel(event.title)
        eventCard.setDateLabel(event.date)
        eventCard.setDetailButtonTitle(
            isPastEvent ? "Ver Detalhse" : "Participar"
        )
        
        if let location = event.locationDetails?.displayString {
            eventCard.setLocationLabel(location)
        }
        if let image = event.image {
            eventCard.setImage(image)
        }
        
        if let category = event.tag {
            eventCard.setTagViewTextColor(
                text: category.title,
                textColor: UIColor(
                    hex: category.color
                ),
                backgroundColor: UIColor(
                    hex: category.bgColor
                )
            )
        }
        
        if let participants = event.participants {
            let listOfNames = participants
                .prefix(3)
                .map( \.name )
            if participants.count > 0 {
                
                let indicatorNumber: Int =
                participants.count > 3
                ? participants.count - 3 : 0
                
                eventCard.setAvatars(
                    listOfNames,
                    indicatorNumber
                )
                
            }
        }
        
        
    }
    
}
// MARK: - Extensions
extension EventCardCollectionViewCell: EventCardViewDelegate {
    func didTapDetailButton(in view: EventCardView) {
        if let event = currentEvent {
            delegate?.didTapDetailButtonInCell(for: event)
        }
    }
}
extension EventCardCollectionViewCell: ViewCode {
    func setHierarchy() {
        contentView.addSubview(eventCard)
    }
    
    func setConstraints() {
        eventCard
            .top(
                anchor: contentView.topAnchor,
                constant: 8
            )
            .bottom(
                anchor: contentView.bottomAnchor,
                constant: -8
            )
            .leading(
                anchor: contentView.leadingAnchor
            )
            .trailing(
                anchor: contentView.trailingAnchor
            )
    }
    
    
}
