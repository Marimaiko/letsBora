//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/03/25.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func seeDetailsTapped()
}

class HomeViewController: UIViewController {
    //MARK: Properties
    private let mainView = HomeView()
    private let viewModel = HomeViewModel()
    private var highlightedEvent: Event?
    private var tableEvents: [Event] = []
    
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
        self.mainView.delegate = self
        configureTableView()
        setupNavigationBar()
    }
    
    private func fetchData() {
        mainView.activityIndicator.startAnimating() // Inicia o loading
        mainView.yourNextEventLabel.isHidden = true
        mainView.eventCardView1.isHidden = true
        
        Task {
            let result = await viewModel.fetchAndDistributeEvents()
            
            // Atualizar a UI na thread principal
            await MainActor.run {
                self.highlightedEvent = result.highlighted
                self.tableEvents = result.list
                
                // Configurar a view com os dados recebidos
                if let event = self.highlightedEvent {
                    mainView.configureNextEventCard(with: event)
                    // Mostrar os componentes relacionados ao "próximo rolê"
                    mainView.yourNextEventLabel.isHidden = false
                    mainView.eventCardView1.isHidden = false
                }
                
                mainView.tableView.reloadData()
                mainView.activityIndicator.stopAnimating() // Para o loading
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

// MARK: - HomeView Delegate
extension HomeViewController: HomeViewDelegate {
    func seeDetailsTapped() {
        // Chamado quando o eventCardView1 (destacado) é tocado
        if let eventToDetail = self.highlightedEvent {
            navigateToDetails(for: eventToDetail)
        } else {
            print("Nenhum evento destacado para mostrar detalhes.")
        }
    }
}

// MARK: - Table View Delegate
extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return tableEvents.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell else {
            return UITableViewCell()
        }
        let event = tableEvents[indexPath.row]
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


