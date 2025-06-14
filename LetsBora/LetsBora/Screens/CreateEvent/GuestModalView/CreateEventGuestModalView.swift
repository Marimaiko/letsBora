//
//  CreateEventGuestModalView.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//

import Foundation
import UIKit

class CreateEventGuestModalView: UIView {
    // MARK: - UI Properties
    struct layout {
        static let marginX: CGFloat = 8
        static let marginY: CGFloat = 16
        static let closeButtonSize: CGFloat = 24
        static let buttonWidth: CGFloat = 128
    }
    // MARK: - UI Elements
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
    
    // MARK: - Functions
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
        addSubview(inviteAFriendTextField)
        addSubview(tableView)
        
    }
    func setConstraints(){
        
        inviteAFriendTextField
            .top(anchor: safeAreaLayoutGuide.topAnchor, constant: layout.marginY)
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

