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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.delegate = self
        configureTableView()
        setupNavigationBar()
    }
    func configureTableView() {
        mainView.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        )
        mainView.tableView.dataSource = self
    }
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        // Apply to both standard and scroll edge appearances
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Optionally also compact appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
}
extension HomeViewController: HomeViewDelegate{
    func seeDetailsTapped() {
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
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})
#endif


