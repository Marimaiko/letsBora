//
//  HomeView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(text: "Let's Bora",labelType: .title)
    private lazy var yourNextEventLabel = ReusableLabel(text: "Seu próximo rolê",labelType: .h2)
    private lazy var highlightEventLabel = ReusableLabel(text: "Destaques",labelType: .h2)

    
    lazy var eventCardView1 = EventCardView()
                            .setTitleLabel("Aniversário do João")
                            .setLocationLabel("Casa do João")
                            .setTagViewTextColor(text: "Particular")
                            .setDateLabel("15 Marc")
                            .setAvatars(["Jim", "John", "Julia"],25)
    
    // MARK: - LifeCycle
    init(){
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .systemGray6
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension HomeView: ViewCode {
    
    func setHierarchy(){
        self.addSubview(titleLabel)
        self.addSubview(yourNextEventLabel)
        self.addSubview(eventCardView1)
        self.addSubview(highlightEventLabel)
    }
    
     func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
            // Title constraints
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            
            // Your Next Event Label constraints
            yourNextEventLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 44),
            yourNextEventLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            
            // Event Card constraints
            eventCardView1.topAnchor.constraint(equalTo: yourNextEventLabel.bottomAnchor, constant: 15),
            eventCardView1.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            eventCardView1.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Highligh Event Label contraints
            highlightEventLabel.topAnchor.constraint(equalTo: eventCardView1.bottomAnchor, constant: 10),
            highlightEventLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    HomeView()
})
