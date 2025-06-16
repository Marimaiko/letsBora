//
//  EventsListView.swift
//  LetsBora
//
//  Created by Joel Lacerda on 16/06/25.
//

import UIKit

// Delegate para ações da view, como mudar o segmento
protocol EventsListViewDelegate: AnyObject {
    func didChangeSegment(to index: Int)
}

class EventsListView: UIView {
    
    weak var delegate: EventsListViewDelegate?
    
    // MARK: - UI Components
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Eventos Públicos", "Meus Eventos"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0 // Começa na primeira aba
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return sc
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        // A seleção da célula será tratada pelo botão dentro dela, então allowsSelection pode ser false.
        // tableView.allowsSelection = false
        return tableView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func segmentChanged() {
        delegate?.didChangeSegment(to: segmentedControl.selectedSegmentIndex)
    }
}

extension EventsListView: ViewCode {
    func setHierarchy() {
        addSubview(segmentedControl)
        addSubview(tableView)
        addSubview(activityIndicator)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
}
