//
//  CreateEventGuestModalView.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//

import Foundation
import UIKit
protocol CreateEventGuestModalDelegate : AnyObject{
    func didTappedCloseButton()
    func didTappedInviteAFriendButton()
}
class CreateEventGuestModalView: UIView {
    // MARK: - View Attributes
    private weak var delegate: CreateEventGuestModalDelegate?
    
    func delegate(_ delegate: CreateEventGuestModalDelegate){
        self.delegate = delegate
    }
    
    
    // MARK: - UI Properties
    struct layout {
        static let marginX: CGFloat = 8
        static let marginY: CGFloat = 16
        static let closeButtonSize: CGFloat = 24
        static let buttonWidth: CGFloat = 128
    }
    // MARK: - UI Elements
    lazy var inviteAFriendLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Convidar um amigo"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    lazy var inviteAFriendTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Pesquisar por nome ou email "
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        textField.returnKeyType = .next
        
        // left side icon
        let paddingView = UIView (
            frame:
                CGRect(
                    x: 0, y: 0,
                    width: layout.marginY * 2 ,
                    height: layout.marginY * 2
                )
        )
        let imageView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: layout.marginY,
                height: layout.marginY
            )
        )
        imageView.image = UIImage(systemName:"magnifyingglass")
        imageView.center = paddingView.center
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
        textField.leftViewMode = .always

        return textField
    }()
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = layout.closeButtonSize / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        tableView.allowsMultipleSelection = true
        tableView.register(
            GuestModalTableViewCell.self,
            forCellReuseIdentifier: GuestModalTableViewCell.identifier
        )
        return tableView
    }()
    
    lazy var inviteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(inviteButtonTapped), for: .touchUpInside)
        return button
    }()

    
    // MARK: - Functions
    @objc func closeButtonTapped(){
        delegate?.didTappedCloseButton()
    }
    @objc func inviteButtonTapped(){
        delegate?.didTappedInviteAFriendButton()
    }
    func delegateTableView(to delegate: UITableViewDelegate, data dataSource: UITableViewDataSource  ){
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    // MARK: - LifeCyles
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemGray6
        setupView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupView(){
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy(){
        addSubview(closeButton)
        addSubview(inviteButton)
        addSubview(inviteAFriendLabel)
        addSubview(inviteAFriendTextField)
        addSubview(tableView)
        
    }
    func setConstraints(){
        closeButton
            .top(anchor: safeAreaLayoutGuide.topAnchor, constant: layout.marginY)
            .leading(anchor: safeAreaLayoutGuide.leadingAnchor, constant: layout.marginX)
            .height(constant: layout.closeButtonSize)
            .width(constant: layout.closeButtonSize)
        
        inviteButton
            .top(anchor: safeAreaLayoutGuide.topAnchor, constant: layout.marginY)
            .trailing(anchor: safeAreaLayoutGuide.trailingAnchor, constant: -layout.marginX)
            .width(constant: layout.buttonWidth)
            
        
        inviteAFriendLabel
            .top(anchor: closeButton.bottomAnchor, constant: layout.marginY)
            .leading(anchor: closeButton.trailingAnchor, constant: layout.marginX)
        
        inviteAFriendTextField
            .top(anchor: inviteAFriendLabel.bottomAnchor, constant: layout.marginY)
            .leading(anchor: safeAreaLayoutGuide.leadingAnchor, constant: layout.marginX)
            .trailing(anchor: safeAreaLayoutGuide.trailingAnchor, constant: -layout.marginX)
            .height(constant: layout.marginY * 3)
        
        tableView
            .top(anchor: inviteAFriendTextField.bottomAnchor, constant: layout.marginY * 2)
            .leading(anchor: safeAreaLayoutGuide.leadingAnchor, constant: layout.marginX)
            .trailing(anchor: safeAreaLayoutGuide.trailingAnchor, constant: -layout.marginX)
            .bottom(anchor: safeAreaLayoutGuide.bottomAnchor, constant: -layout.marginY)
    }
    
}

