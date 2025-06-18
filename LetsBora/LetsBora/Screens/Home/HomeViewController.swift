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
    private let viewModel = HomeViewModel()
    
    private var events: [Event] = []
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        fetchData()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupNavigationBar()
    }
    
    private func fetchData() {
        mainView.activityIndicator.startAnimating()
        Task {
            let fetchedEvents = await viewModel.fetchFutureEvents()
            
            await MainActor.run {
                self.events = fetchedEvents
                mainView.tableView.reloadData()
                mainView.activityIndicator.stopAnimating()
            }
        }
    }
    
    func configureTableView() {
        mainView.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        )
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
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
    
    private func navigateToDetails(for event: Event) {
        let detailVC = EventDetailsViewController(event: event)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Table View Delegate
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return events.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell else {
            return UITableViewCell()
        }
        let event = events[indexPath.row]
        cell.setupCell(with: event)
        cell.cellDelegate = self
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

// Novo Delegate da Célula (para os eventos na tableView)
extension HomeViewController: EventCardTableViewCellDelegate {
    func didTapDetailButtonInCell(for event: Event) {
        navigateToDetails(for: event)
    }
}


// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})
#endif


