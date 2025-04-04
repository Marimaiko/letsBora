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
    
    lazy var eventCardView1 = EventCardView()
        .setTitleLabel("Aniversário do João")
        .setLocationLabel("Casa do João")
        .setTagViewTextColor(text: "Particular")
        .setDateLabel("15 Marc")
        .setAvatars(["Jim", "John", "Julia"], 25)
    
    lazy var nextCardView1 = EventCardView()
        .setTitleLabel("Festival de Verão 2025")
        .setLocationLabel("Arena Show - São Paulo, SP")
        .setDateLabel("25 Mar")
        .setTagViewTextColor(text: "Show",textColor: .black, backgroundColor: .systemYellow)
        .setAvatars(["","",""],12)
        .setDetailButtonTitle("Participar")
        .setImage("imageCard1")
    
    lazy var nextCardView2 = EventCardView()
        .setTitleLabel("Show dos Casca de Bala")
        .setLocationLabel("Kukukaya - Uberlândia, MG")
        .setDateLabel("30 Ago")
        .setTagViewTextColor(text: "Show",textColor: .black,backgroundColor: .systemYellow)
        .setAvatars(["",""])
        .setDetailButtonTitle("Participar")
        .setImage("imageCard2")
    
    lazy var nextCardView3 = EventCardView()
        .setTitleLabel("Vôlei de Praia")
        .setLocationLabel("Praia do Futuro - Fortaleza, CE")
        .setDateLabel("30 Abr")
        .setTagViewTextColor(text: "Jogos",textColor: .black,backgroundColor: .green)
        .setAvatars(["","",""],2)
        .setDetailButtonTitle("Participar")
        .setImage("imageCard3")
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [ nextCardView1,
                                nextCardView2,
                                nextCardView3
                              ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        return stackView
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
        self.addSubview(scrollView)
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(yourNextEventLabel)
        scrollView.addSubview(eventCardView1)
        scrollView.addSubview(highlightEventLabel)
        scrollView.addSubview(stackView)
        
    }
    
    func setConstraints() {
        
        // scrollView Constraints
        scrollView
            .top(anchor: self.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: self.leadingAnchor)
            .trailing(anchor: self.trailingAnchor)
            .bottom(anchor: self.safeAreaLayoutGuide.bottomAnchor)
        
        // title constraints
        titleLabel
            .top(anchor: scrollView.topAnchor)
            .leading(anchor: scrollView.leadingAnchor,constant: 18)
        
        // next event label  constraints
        yourNextEventLabel
            .top(anchor: titleLabel.bottomAnchor,constant: 20)
            .leading(anchor: scrollView.leadingAnchor,constant: 18)
        
        // event card view
        eventCardView1
            .top(anchor: yourNextEventLabel.bottomAnchor, constant: 15)
            .leading(anchor: scrollView.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
        
        // Highlight Event Label constraints
        highlightEventLabel
            .top(anchor: eventCardView1.bottomAnchor, constant: 10)
            .leading(anchor: scrollView.leadingAnchor,constant: 20)
        
        // Stack View Events constraints
        stackView
            .top(anchor: highlightEventLabel.bottomAnchor,constant: 8)
            .leading(anchor: scrollView.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
            .bottom(anchor: scrollView.bottomAnchor,constant: -16)
        
        
    }
}

// MARK: - Preview

@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    
    HomeView()
    
})
