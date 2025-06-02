//
//  GuestModalTableViewCell.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//

import UIKit

class GuestModalTableViewCell: UITableViewCell {
    // MARK: - Cell Attributes
    static let identifier: String = String(
        describing:
            GuestModalTableViewCell.self
    )
    // MARK: - UI Elements
    private lazy var avatarImageView: AvatarImageView = {
        var avatarImageView = AvatarImageView(size: 60)
        avatarImageView.translatesAutoresizingMaskIntoConstraints  = false
        return avatarImageView
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize:16)
        label.textColor = .black
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize:12)
        label.textColor = .black
        return label
    }()
    
    private lazy var checkBoxButton: CheckboxButton = {
        var checkBoxButton = CheckboxButton()
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false
        return checkBoxButton
    }()
    
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup UI
    private func addSubViews() {
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(emailLabel)
        addSubview(checkBoxButton)
    }
    private func setupConstraints() {
        avatarImageView
            .centerY(centerYAnchor)
            .top(anchor: topAnchor, constant: 8)
            .leading(anchor: leadingAnchor, constant: 16)
            .bottom(anchor: bottomAnchor, constant: -8)
        
        labelName
            .centerY(centerYAnchor, constant: -8)
            .leading(anchor: avatarImageView.trailingAnchor, constant: 16)
        
        emailLabel
            .centerY(centerYAnchor,constant: 8)
            .leading(anchor: avatarImageView.trailingAnchor, constant: 16)
        
        checkBoxButton
            .centerY(centerYAnchor)
            .trailing(anchor: trailingAnchor, constant: -16)
        
    }
    // MARK: - Functions
    func setupCell(with guest: User){
        
        if let photo = guest.photo {
            avatarImageView.setImage(named: photo)
        }
        
        labelName.text = guest.name
        emailLabel.text = guest.email ?? ""
        
    }
    var stateCell: Bool {
        return checkBoxButton.isChecked
    }
    func selectToogleCell(_ state: Bool){
        checkBoxButton.setChecked(state)
    }
}
