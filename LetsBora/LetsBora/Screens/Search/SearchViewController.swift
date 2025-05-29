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
    private var tags: [Tag] = MockData.tags
    
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
    }
    func configureUI() {
        configureTableView()
        configureCollectionView()
    }
    func configureTableView() {
        mainView.tableView.register(
            EventCardTableViewCell.self,
            forCellReuseIdentifier: EventCardTableViewCell.identifier
        
        )
        mainView.tableView.dataSource = self
    }
    func configureCollectionView() {
        mainView.collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
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
// MARK: - Extension Collection View
extension SearchViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell
        cell?.setupCell(with: tags[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 5 // 5 colunas com espaçamento
        return CGSize(width: width, height: self.mainView.heightCollectionView)
    }
}
// MARK: - Preview Profile
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    SearchViewController()
})
#endif
