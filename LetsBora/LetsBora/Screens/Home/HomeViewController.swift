//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: Properties
    private let mainView = HomeView()
    private var events: [Event] = MockData.events
    
    // MARK: - LifeCycle
    /// before didLoad used to ref view
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.delegate = self
        configureTableView()
    }
    func configureTableView() {
        mainView.tableView.register(EventCardTableViewCell.self, forCellReuseIdentifier: EventCardTableViewCell.identifier)
        mainView.tableView.dataSource = self
    }

}
extension HomeViewController: HomeViewDelegate{
    func seeDetailsTapped() {
        print("Item Tapped")
        let detailVC = EventDetailsViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

// MARK: - Table View Delegate
extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return events.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell
           cell?.setupCell(with: events[indexPath.row])
           return cell ?? UITableViewCell()
       }
}


// MARK: - Preview
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})


