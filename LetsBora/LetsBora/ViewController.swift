//
//  ViewController.swift
//  LetsBora
//
//  Created by Davi  on 21/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    var events: [Event] = mockEvents
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureTableView()
    }

    func configureTableView() {
        tableView.register(EventCardTableViewCell.self, forCellReuseIdentifier: EventCardTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell
        cell?.setupCell(with: events[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - ViewCode Conformance
extension ViewController: ViewCode {
    func setHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView
            .setContraintsToParent(self.view)
    }
}

@available(iOS 17.0, *)
#Preview("table view", traits: .sizeThatFitsLayout) {
    ViewController()
}
