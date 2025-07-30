//
//  NotificationView.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/07/25.
//
import UIKit
class NotificationView: UIView {
    // MARK: - UI Components
    private lazy var notificationTableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
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
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        notificationTableView.register(
            cell,
            forCellReuseIdentifier: String(describing: cell)
        )
    }
    func delegateTableView(
        _ delegate: UITableViewDelegate,
        _ delegateDataSource: UITableViewDataSource
    ) {
        notificationTableView.delegate = delegate
        notificationTableView.dataSource = delegateDataSource
    }
    func reloadTable(){
        notificationTableView.reloadData()
    }
}
// MARK: - ViewCode Extension
extension NotificationView: ViewCode {
    func setHierarchy() {
        addSubview(notificationTableView)
    }
    
    func setConstraints() {
        notificationTableView
            .top(anchor: safeAreaLayoutGuide.topAnchor, constant: 16)
            .leading(anchor: safeAreaLayoutGuide.leadingAnchor, constant: 16)
            .trailing(anchor: safeAreaLayoutGuide.trailingAnchor, constant: -16)
            .bottom(anchor: safeAreaLayoutGuide.bottomAnchor, constant: -16)
    }
    
    
}
