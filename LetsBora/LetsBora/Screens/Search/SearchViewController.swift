//
//  SearchViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 11/04/25.
//

import UIKit

class SearchViewController: ViewController {
    //MARK: Properties
    private let mainView = SearchView()
    private var events: [Event] = MockData.events
    
    // MARK: - LifeCycle
    override func loadView() {
        self.view  = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    func configureTableView() {
        mainView.tableView.register(EventCardTableViewCell.self, forCellReuseIdentifier: EventCardTableViewCell.identifier)
        mainView.tableView.dataSource = self
    }
}
// MARK: - Extension table view
extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return events.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell
           cell?.setupCell(with: events[indexPath.row])
           return cell ?? UITableViewCell()
       }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    SearchViewController()
})
