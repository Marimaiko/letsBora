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
        viewModel.loadEvents()
    }
    
    override func loadView() {
        mainView = MyEventsView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        mainView?.delegateTo(self)
        viewModel.delegate(self)
        
    }
    
    private func loadDataAndUpdateView() {
        mainView?.tableView.reloadData()
        mainView?.nextEventCollectionView.reloadData()
    }
    
    
    func configureTableView() {
        // configure table view
        mainView?.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        )
        mainView?.tableView.dataSource = self
        
        // configure collection view
        mainView?.nextEventCollectionView.register(
            EventCardCollectionViewCell.self
            ,
            forCellWithReuseIdentifier:
                EventCardCollectionViewCell.identifier
        )
        mainView?.nextEventCollectionView.dataSource = self
    }
    
    // Função helper para navegação
    private func navigateToDetails(
        for event: Event,
        isPast: Bool = false
    ) {
        let detailVC = EventDetailsViewController(event: event)
        // Passa o evento correto
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
        if let eventToShow = viewModel.nextEvent {
            // Usa o evento que definimos como "próximo"
            navigateToDetails(
                for: eventToShow,
                isPast: false
            )
            // Próximo evento não é "passado"
        } else {
            print("Nenhum 'próximo evento' definido para exibir detalhes.")
            // Opcional: Mostrar um alerta ou tratar o caso de nenhum evento em destaque.
        }
    }
}
// MARK: - ViewModel Delegate extenstions
extension MyEventsViewController: MyEventViewModelDelegate {
    func didUpdateEvents() {
        loadDataAndUpdateView()
    }

    func didFailToLoadEvents(with error: Error) {
        // Show an alert or handle the error
        print("Failed to load events: \(error.localizedDescription)")
    }
}
// MARK: - Collection View Data Source Delegate
extension MyEventsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.nextEvents.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: EventCardCollectionViewCell.identifier,
                for: indexPath
            ) as? EventCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let event = viewModel.nextEvents[indexPath.row]
        cell.setupCell(with: event)
        return cell
    }
}

// MARK: - Table View Delegate
extension MyEventsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pastEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EventCardTableViewCell.identifier,
            for: indexPath
        ) as? EventCardTableViewCell else {
            return UITableViewCell()
        }
        
        let event = viewModel.pastEvents[indexPath.row]
        cell.setupCell(with: event, isPast: true)
        cell.cellDelegate = self
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
