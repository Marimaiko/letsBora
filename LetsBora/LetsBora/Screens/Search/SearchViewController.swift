//
//  SearchViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 11/04/25.
//

import UIKit

//TODO: Fazer separação com view model
class SearchViewController: ViewController {
    //MARK: Properties
    private let mainView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var events: [Event] = []
    private var tags: [Tag] = []
    private var selectedTag: Tag?
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        self.view  = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchInitialData()
    }
    
    private func fetchInitialData() {
        mainView.activityIndicator.startAnimating()
        Task {
            // Busca as tags para a collectionView
            let fetchedTags = await viewModel.fetchTags()
            // Busca uma lista inicial de eventos (todos os públicos futuros)
            let initialEvents = await viewModel.searchEvents(withText: nil, forTag: nil)
            
            await MainActor.run {
                self.tags = fetchedTags
                self.events = initialEvents
                self.mainView.collectionView.reloadData()
                self.mainView.tableView.reloadData()
                self.mainView.activityIndicator.stopAnimating()
            }
        }
    }
    
    func configureUI() {
        configureTableView()
        configureCollectionView()
        mainView.searchEventTextField.delegate = self
    }
    
    func configureTableView() {
        mainView.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        
        )
        mainView.tableView.dataSource = self
    }
    func configureCollectionView() {
        mainView.collectionView.register(
            TagCollectionViewCell.self,
            forCellWithReuseIdentifier: TagCollectionViewCell.identifier
        )
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    private func performSearch() {
        let searchText = mainView.searchEventTextField.text
        
        mainView.activityIndicator.startAnimating()
        Task {
            let filteredEvents = await viewModel.searchEvents(withText: searchText, forTag: self.selectedTag)
            
            await MainActor.run {
                self.events = filteredEvents
                self.mainView.tableView.reloadData()
                self.mainView.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func navigateToDetails(for event: Event) {
        let detailVC = EventDetailsViewController(event: event)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - TableView (Eventos) e CollectionView (Tags)
extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return events.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCardTableViewCell.identifier, for: indexPath) as? EventCardTableViewCell else { return UITableViewCell()
        }
        cell.setupCell(with: events[indexPath.row])
        cell.cellDelegate = self
        return cell
    }
}

extension SearchViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell()
        }
        cell.setupCell(with: tags[indexPath.row])
        cell.isSelected = (tags[indexPath.row].id == selectedTag?.id)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedTag = tags[indexPath.row]
        if selectedTag?.id == tappedTag.id {
            selectedTag = nil
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            selectedTag = tappedTag
        }
        collectionView.reloadData()
        performSearch()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }
}

extension SearchViewController: EventCardTableViewCellDelegate {
    func didTapDetailButtonInCell(for event: Event) {
        navigateToDetails(for: event)
    }
}

// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    SearchViewController()
})
#endif
