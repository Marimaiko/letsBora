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
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       // MARK: - Public Method
       public func setupCell(with event: Event) {
           eventCard.setTitleLabel(event.title)
           eventCard.setLocationLabel(event.location)
           eventCard.setDateLabel(event.date)
           eventCard.setDetailButtonTitle("Participar")
           
           if let image = event.image {
               eventCard.setImage(image)
           }
           
           if let category = event.category {
               eventCard.setTagViewTextColor(text: category.title,
                                             textColor: category.color,
                                             backgroundColor: category.bgColor)
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
            .top(anchor: contentView.topAnchor, constant: 12)
            .leading(anchor: contentView.leadingAnchor, constant: 16)
            .trailing(anchor: contentView.trailingAnchor,constant: -16)
            .bottom(anchor: contentView.bottomAnchor, constant: -12)
    }
    
    
}
