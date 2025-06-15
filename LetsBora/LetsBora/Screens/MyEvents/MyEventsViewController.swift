//
//  MyEventsViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 30/04/25.
//

import UIKit

class MyEventsViewController: UIViewController {
    //MARK: Properties
    private var mainView: MyEventsView?
    private var events: [Event]?
    private var nextEvent: Event?
    private var viewModel: MyEventViewModel = MyEventViewModel()
    
    // MARK: - LifeCycle
    override func viewWillAppear(
        _ animated: Bool
    ) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            true,
            animated: animated
        )
        // fetch data
        viewModel.loadEvents { [weak self] events in
            guard let self = self else { return }
            self.events = events
            print("events fetched \(events.count) successfully")
            loadDataAndUpdateView()
        }
    }
    
    override func loadView() {
        mainView = MyEventsView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.mainView?.delegate = self
        
    }
    
    private func loadDataAndUpdateView() {
        
        // Lógica para carregar/definir o nextEvent e pastEvents
        // Por enquanto, vamos pegar o primeiro dos "MockData.events" como "próximo evento"
        // e os "MockData.pastEvents" para a tabela.
        // Em um app real, isso viria de um ViewModel ou serviço.
        
        // Configurar o eventCardView1 (próximo rolê)
        // Precisamos de uma maneira para a MyEventsView atualizar seu eventCardView1 dinamicamente.
        // Se eventCardView1 é fixo na MyEventsView com dados mockados,
        // o nextEvent aqui é mais para saber qual evento abrir ao tocar nele.
        // Vamos assumir que MockData.eventMock1 (ou similar) é o "próximo evento"
        // que MyEventsView.eventCardView1 está mostrando.
        if let potentialNextEvent = MockData.events.first(where: { $0.title == "Aniversário do João" }) { // Exemplo de como identificar o evento do eventCardView1
            self.nextEvent = potentialNextEvent
            // Se a MyEventsView tiver um método para configurar o eventCardView1:
            // self.mainView.configureNextEventCard(with: potentialNextEvent)
        } else if !MockData.events.isEmpty {
            self.nextEvent = MockData.events.first // Fallback
        }
        
        
        // Para a tableView, os dados já estão em self.pastEvents
        self.mainView?.tableView.reloadData()
    }

    
    func configureTableView() {
        mainView?.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        )
        mainView?.tableView.dataSource = self
    }

    // Função helper para navegação
    private func navigateToDetails(
        for event: Event,
        isPast: Bool = false
    ) {
        let detailVC = EventDetailsViewController(event: event) // Passa o evento correto
        // Você pode querer passar 'isPast' para EventDetailsViewController se ele se comportar diferente
        // Ex: detailVC.isPastEvent = isPast
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - MyEventsViewDelegate (para o eventCardView1)
extension MyEventsViewController: MyEventsViewDelegate {
    func seeDetailsTapped() {
        // Este é chamado pelo eventCardView1 da MyEventsView
        if let eventToShow = self.nextEvent { // Usa o evento que definimos como "próximo"
            navigateToDetails(
                for: eventToShow,
                isPast: false
            ) // Próximo evento não é "passado"
        } else {
            print("Nenhum 'próximo evento' definido para exibir detalhes.")
            // Opcional: Mostrar um alerta ou tratar o caso de nenhum evento em destaque.
        }
    }
}

// MARK: - Table View Delegate
extension MyEventsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("events?.count ?? 0: \(events?.count ?? 0)")
        
        return events?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EventCardTableViewCell.identifier,
            for: indexPath
        ) as? EventCardTableViewCell else {
            return UITableViewCell()
        }
        
        guard let events = self.events else {
            return UITableViewCell()
        }
        let event = events[indexPath.row]
        cell.setupCell(with: event, isPast: true) // Passando isPast: true como no original
        cell.cellDelegate = self // MyEventsViewController é o delegate da célula
        return cell
    }
}

// MARK: - EventCardTableViewCellDelegate
extension MyEventsViewController: EventCardTableViewCellDelegate {
    func didTapDetailButtonInCell(for event: Event) {
        navigateToDetails(for: event, isPast: true)
    }
}


// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("MyEventsViewController", traits: .portrait, body: {
    MyEventsViewController()
})
#endif
