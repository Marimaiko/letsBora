//
//  EventsListViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 16/06/25.
//

import UIKit

class EventsListViewController: UIViewController {

    private let screen = EventsListView()
    private let viewModel = EventsListViewModel()
    
    private var eventsToShow: [Event] = []
    
    override func loadView() {
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eventos" // Título para a Navigation Bar
        screen.delegate = self
        configureTableView()
        fetchEvents(forSegment: 0) // Busca os eventos públicos inicialmente
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Você pode querer re-buscar os eventos aqui se eles puderem mudar
        // fetchEvents(forSegment: screen.segmentedControl.selectedSegmentIndex)
    }

    private func configureTableView() {
        screen.tableView.dataSource = self
        screen.tableView.delegate = self // Para didSelectRowAt
        screen.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        )
    }
    
    private func fetchEvents(forSegment index: Int) {
        screen.activityIndicator.startAnimating()
        Task {
            var fetchedEvents: [Event] = []
            if index == 0 { // Segmento "Eventos Públicos"
                fetchedEvents = await viewModel.fetchPublicEvents()
            } else { // Segmento "Meus Eventos"
                fetchedEvents = await viewModel.fetchUserEvents()
            }
            
            // Atualizar UI na thread principal
            await MainActor.run {
                self.eventsToShow = fetchedEvents
                self.screen.tableView.reloadData()
                self.screen.activityIndicator.stopAnimating()
                // Opcional: Mostrar um label se não houver eventos
                if self.eventsToShow.isEmpty {
                    // self.screen.showEmptyStateLabel("Nenhum evento encontrado.")
                } else {
                    // self.screen.hideEmptyStateLabel()
                }
            }
        }
    }
    
    private func navigateToDetails(for event: Event) {
        let detailVC = EventDetailsViewController(event: event)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension EventsListViewController: EventsListViewDelegate {
    func didChangeSegment(to index: Int) {
        fetchEvents(forSegment: index)
    }
}

extension EventsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell else {
            return UITableViewCell()
        }
        let event = eventsToShow[indexPath.row]
        cell.setupCell(with: event)
        cell.cellDelegate = self // Para o botão de detalhes
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navega ao tocar na célula inteira
        tableView.deselectRow(at: indexPath, animated: true)
        let event = eventsToShow[indexPath.row]
        navigateToDetails(for: event)
    }
}

extension EventsListViewController: EventCardTableViewCellDelegate {
    func didTapDetailButtonInCell(for event: Event) {
        // Navega ao tocar no botão de detalhes dentro da célula
        navigateToDetails(for: event)
    }
}
