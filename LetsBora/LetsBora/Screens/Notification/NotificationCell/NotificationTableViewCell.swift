//
//  NotificationTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/07/25.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {    
    static let identifier = String(describing: NotificationTableViewCell.self)
    
    // MARK: - UI Compontents
    private lazy var titleLabel: ReusableLabel = {
        var reusableLabel = ReusableLabel(
        labelType: .h4
       )
        return reusableLabel
    }()
    
    private lazy var notificationTextLabel: ReusableLabel = {
        var reusableLabel = ReusableLabel(
            labelType: .body
        )
        return reusableLabel
    }()
    
    // MARK: - Init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ){
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupView()
        
        // set content View style
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method
    func configure(with message: MessageNotification){
        titleLabel.updateText(message.title)
        notificationTextLabel.updateText(message.text)
    }
}

extension NotificationTableViewCell: ViewCode {
    func setHierarchy() {
        addSubview(titleLabel)
        addSubview(notificationTextLabel)
    }
    
    func setConstraints() {
        titleLabel
            .top(anchor: topAnchor, constant: 8)
            .leading(anchor: leadingAnchor, constant: 8)
            .trailing(anchor: trailingAnchor, constant: -8)
            
        
        notificationTextLabel
            .top(
                anchor: titleLabel.bottomAnchor,
                constant: 8
            )
            .leading(anchor: leadingAnchor, constant: 8)
            .trailing(anchor: trailingAnchor, constant: -8)
            .bottom(anchor: bottomAnchor, constant: -8)
            .heightAnchor
            .constraint(
                lessThanOrEqualToConstant: 100
            ).isActive = true
    }
    
    
}
