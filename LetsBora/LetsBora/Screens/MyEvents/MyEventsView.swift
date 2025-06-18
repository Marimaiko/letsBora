//
//  MyEventsView.swift
//  LetsBora
//
//  Created by Joel Lacerda on 30/04/25.
//

import UIKit

protocol MyEventsViewDelegate: AnyObject {
    func seeDetailsTapped()
}

class MyEventsView: UIView {
    private weak var delegate: MyEventsViewDelegate?
    func delegateTo(_ delegate: MyEventsViewDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(text: "Meus Eventos", labelType: .title)
    private lazy var yourNextEventLabel = ReusableLabel(text: "Meu próximo rolê", labelType: .h2)
    private lazy var pastEventsLabel = ReusableLabel(text: "Eventos passados", labelType: .h2)
    
    lazy var nextEventCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(
            width: 350,
            height: 145
        )
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = false
        
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.backgroundColor =  .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - ViewCode Extension
extension MyEventsView: ViewCode {
    
    func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(yourNextEventLabel)
        self.addSubview(nextEventCollectionView)
        self.addSubview(pastEventsLabel)
        self.addSubview(tableView)
        
    }
    
    func setConstraints() {
        // title constraints
        titleLabel
            .top(anchor: self.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: self.leadingAnchor,constant: 18)
        
        // next event label  constraints
        yourNextEventLabel
            .top(anchor: titleLabel.bottomAnchor,constant: 20)
            .leading(anchor: self.leadingAnchor,constant: 18)
        
        // event card view
        nextEventCollectionView
            .top(anchor: yourNextEventLabel.bottomAnchor, constant: 15)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
            .height(constant: 145)
        
        // Highlight Event Label constraints
        pastEventsLabel
            .top(anchor: nextEventCollectionView.bottomAnchor, constant: 10)
            .leading(anchor: self.leadingAnchor,constant: 20)
        
        // table View Events constraints
        tableView
            .top(anchor: pastEventsLabel.bottomAnchor,constant: 8)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
            .bottom(anchor: self.bottomAnchor,constant: -16)
    }
}
extension MyEventsView: EventCardViewDelegate {
    func didTapDetailButton(in view: EventCardView) {
        self.delegate?.seeDetailsTapped()
    }
    
}
// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    MyEventsViewController()
})
#endif
