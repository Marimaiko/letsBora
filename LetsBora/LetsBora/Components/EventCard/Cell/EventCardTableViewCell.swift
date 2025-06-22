//
//  EventCardTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//

import UIKit

protocol EventCardTableViewCellDelegate: AnyObject {
    func didTapDetailButtonInCell(for event: Event)
}

class EventCardTableViewCell: UITableViewCell, EventCardViewDelegate {
    // Identifier for reuse
    static let identifier: String = String(
        describing: EventCardTableViewCell.self
    )

    // MARK: - UI Components
    private lazy var eventCard = EventCardView()
    private var currentEvent: Event?
    weak var cellDelegate: EventCardTableViewCellDelegate?

    // MARK: - Init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupView()
        
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        eventCard.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Ex: "May 15, 2025"
        formatter.timeStyle = .short  // Ex: "9:30 AM"
        return formatter
    }()

    // MARK: - Public Method
    public func setupCell(
        with event: Event,
        isPast: Bool = false
    ) {
        self.currentEvent = event
        
        eventCard.setTitleLabel(event.title)
        
        eventCard.setLocationLabel(
            event.locationDetails?.displayString
            ?? "Local não informado"
        )
        
        eventCard.setDateLabel(event.date)
        
        eventCard.setDetailButtonTitle(!isPast ? "Participar" : "Ver Detalhes")
        
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
    
    // MARK: - EventCardViewDelegate
    func didTapDetailButton(in view: EventCardView) {
        print("Tapped Detail Button")
        if let event = currentEvent {
            cellDelegate?.didTapDetailButtonInCell(for: event)
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
