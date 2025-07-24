//
//  HomeView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class HomeView: UIView {
    // MARK: - UI Components
    lazy var titleLabel = ReusableLabel(text: "Let's Bora", labelType: .title)
    lazy var notificationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bell")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView

    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.backgroundColor =  .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Functions
    func setNotificationAvailability(_ isAvailable: Bool) {
        let image = isAvailable ?
        UIImage(systemName: "bell.badge") :
        UIImage(systemName: "bell")
        
        notificationImageView.image = image
        
    }
}
// MARK: - ViewCode Extension
extension  HomeView: ViewCode {
    
    func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(notificationImageView)
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
    }
    
    func setConstraints() {
        // title constraints
        titleLabel
            .top(anchor: self.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: self.leadingAnchor,constant: 18)
        
        // notification button constraints
        notificationImageView
            .top(anchor: safeAreaLayoutGuide.topAnchor, constant: 18)
            .trailing(anchor: trailingAnchor, constant: -18)
            .height(constant: 32)
            .width(constant: 32)
        
        // table View Events constraints
        tableView
            .top(anchor: titleLabel.bottomAnchor,constant: 20)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
            .bottom(anchor: self.safeAreaLayoutGuide.bottomAnchor)
        
        activityIndicator
            .centerX(self.centerXAnchor)
            .centerY(self.centerYAnchor)
    }
}

// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    
    HomeViewController()
    
})
#endif
