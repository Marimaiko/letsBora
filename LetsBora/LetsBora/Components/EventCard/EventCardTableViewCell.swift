//
//  EventCardTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//

import UIKit

class EventCardTableViewCell: UITableViewCell {
    // Identifier for reuse
    static let identifier: String = String(describing: EventCardTableViewCell.self)
    
    // MARK: - UI Components
    private lazy var eventCard = EventCardView()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    public func setupCell(with event: Event, isPast: Bool = false) {
        // set mandatory arguments
        eventCard.setTitleLabel(event.title)
        eventCard.setLocationLabel(event.location)
        eventCard.setDateLabel(event.date)
        eventCard.setDetailButtonTitle(!isPast ? "Participar" : "Ver Detalhes")
        
        // set optionals
        if let image = event.image {
            eventCard.setImage(image)
        }
        
        if let category = event.tag {
            eventCard.setTagViewTextColor(
                text: category.title,
                textColor: UIColor(hex: category.color),
                backgroundColor: UIColor(hex: category.bgColor)
            )
        }
        
        if let participants = event.participants {
            let listOfNames = participants
                .prefix(3)
                .map{$0.name}
            if participants.count > 0 {
                let indicatorNumber: Int = participants.count > 3  ? participants.count - 3 : 0
                eventCard.setAvatars(listOfNames, indicatorNumber )
            }
        }
    }
}
extension EventCardTableViewCell : ViewCode {
    func setHierarchy() {
        contentView.addSubview(eventCard)
    }
    
    func setConstraints() {
        eventCard
            .top(anchor: contentView.topAnchor, constant: 8)
            .bottom(anchor: contentView.bottomAnchor, constant: -8)
            .leading(anchor: contentView.leadingAnchor)
            .trailing(anchor: contentView.trailingAnchor)
    }
    
    
}
