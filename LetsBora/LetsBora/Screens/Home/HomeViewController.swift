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
    private var allEvents: [Event] = MockData.events // Todos os eventos, incluindo o próximo
    private var highlightedEvent: Event? // O evento para o eventCardView1
    private var tableEvents: [Event] = [] // Eventos para a tableView (excluindo o destacado)

    // private var viewModel = HomeViewModel() // Quando você começar a usar o ViewModel
    
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
        loadAndDistributeEvents()
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
    
    private func loadAndDistributeEvents() {
        // Lógica para determinar o evento destacado e os eventos da tabela.
        // Exemplo: O primeiro evento da lista geral é o destacado.
        // Em um app real, isso viria de um ViewModel com lógica de negócios.
        
        // Para o exemplo, vamos definir o eventMock1 como o destacado
        // e o resto para a tabela.
        if let highlight = MockData.events.first(where: { $0.id == MockData.eventMock1.id }) { // Supondo que eventMock1 é o desejado
            self.highlightedEvent = highlight
            mainView.configureNextEventCard(with: highlight) // Configura a HomeView
            
            // Preenche tableEvents com os eventos restantes
            self.tableEvents = MockData.events.filter { $0.id != highlight.id }
        } else {
            // Fallback se não encontrar o evento específico
            self.highlightedEvent = MockData.events.first
            if let first = self.highlightedEvent {
                mainView.configureNextEventCard(with: first)
                self.tableEvents = Array(MockData.events.dropFirst())
            } else {
                self.tableEvents = []
            }
        }
        mainView.tableView.reloadData()
    }
    
    // Função para navegar para os detalhes do evento
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


