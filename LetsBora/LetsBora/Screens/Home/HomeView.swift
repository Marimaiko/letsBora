//
//  HomeView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(text: "Let's Bora", labelType: .title)
    private lazy var yourNextEventLabel = ReusableLabel(text: "Seu próximo rolê", labelType: .h2)
    private lazy var highlightEventLabel = ReusableLabel(text: "Destaques", labelType: .h2)
    
    private lazy var eventCardView1 : EventCardView = {
        let eventCard = EventCardView()
        eventCard.setTitleLabel("Aniversário do João")
        eventCard.setLocationLabel("Casa do João")
        eventCard.setTagViewTextColor(text: "Particular")
        eventCard.setDateLabel("15 Marc")
        eventCard.setAvatars(["Jim", "John", "Julia"], 25)
        
        return eventCard
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
extension  HomeView: ViewCode {
    
    func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(yourNextEventLabel)
        self.addSubview(eventCardView1)
        self.addSubview(highlightEventLabel)
        self.addSubview(tableView)
        
    }
    
    func setConstraints() {
        // title constraints
        titleLabel
            .top(anchor: self.topAnchor,constant: 48)
            .leading(anchor: self.leadingAnchor,constant: 18)
        
        // next event label  constraints
        yourNextEventLabel
            .top(anchor: titleLabel.bottomAnchor,constant: 20)
            .leading(anchor: self.leadingAnchor,constant: 18)
        
        // event card view
        eventCardView1
            .top(anchor: yourNextEventLabel.bottomAnchor, constant: 15)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
        
        // Highlight Event Label constraints
        highlightEventLabel
            .top(anchor: eventCardView1.bottomAnchor, constant: 10)
            .leading(anchor: self.leadingAnchor,constant: 20)
        
        // table View Events constraints
        tableView
            .top(anchor: highlightEventLabel.bottomAnchor,constant: 8)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
            .bottom(anchor: self.bottomAnchor,constant: -16)
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    
    HomeViewController()
    
})
