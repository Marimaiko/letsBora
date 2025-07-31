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
            labelType: .captionRegular
        )
        reusableLabel.numberOfLines = 2
        reusableLabel.lineBreakMode = .byTruncatingTail
        return reusableLabel
    }()
    private lazy var dataTextLabel: ReusableLabel = {
        var reusableLabel = ReusableLabel(labelType: .subCaption)
        return reusableLabel
    }()
    private lazy var isReadedImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Constraint Groups
    private var isReadedImageConstaints: [NSLayoutConstraint] = []


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
        setupConstraintGroups()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraintGroups(){
        isReadedImageConstaints = [
            isReadedImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            isReadedImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            isReadedImage.heightAnchor.constraint(equalToConstant: 16),
            isReadedImage.widthAnchor.constraint(equalToConstant: 16)
        ]
    }
    // MARK: - Public Method
    func configure(with message: MessageNotification){
        titleLabel.updateText(message.title)
        notificationTextLabel.updateText(message.text)
        dataTextLabel.updateText(message.createdAt.toString())
        
        if !message.isRead {
               if isReadedImage.superview == nil { // evita adicionar duplicado
                   addSubview(isReadedImage)
                   NSLayoutConstraint.activate(isReadedImageConstaints)
               }
           } else {
               if isReadedImage.superview != nil {
                   NSLayoutConstraint.deactivate(isReadedImageConstaints)
                   isReadedImage.removeFromSuperview()
               }
           }
        
    }
}

extension NotificationTableViewCell: ViewCode {
    
    func setHierarchy() {
        addSubview(titleLabel)
        addSubview(notificationTextLabel)
        addSubview(dataTextLabel)
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
            .heightAnchor
            .constraint(
                lessThanOrEqualToConstant: 100
            ).isActive = true
            
        dataTextLabel
            .top(anchor: notificationTextLabel.bottomAnchor, constant: 16)
            .leading(anchor: leadingAnchor, constant: 8)
            .bottom(anchor: bottomAnchor, constant: -8)

                 
    }
    
    
}
