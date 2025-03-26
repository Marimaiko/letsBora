//
//  HomeView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - UI Components
    private lazy var titleLabel = createLabel(withText: "Let's Bora",fontSize: 48)
    private lazy var yourNextEventLabel = createLabel(withText: "Seu próximo rolê",fontSize: 24)
    
    lazy var eventCardView = EventCardView(
        title:"Aniversário do João",
        location:"Casa do João",
        tag: "Particular",
        date: "15 Marc"
    )
    
    
    // MARK: - LifeCycle
    init(){
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup View
    private func setupView() {
        setHierarchy()
        setConstraints()
        self.backgroundColor = .systemGray6
    }
    private func setHierarchy(){
        self.addSubview(titleLabel)
        self.addSubview(yourNextEventLabel)
        self.addSubview(eventCardView)
    }
    
    private func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
            // Title constraints
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            
            // Your Next Event Label constraints
            yourNextEventLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 44),
            yourNextEventLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            
            // Event Card constraints
            eventCardView.topAnchor.constraint(equalTo: yourNextEventLabel.bottomAnchor, constant: 15),
            eventCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            eventCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            eventCardView.heightAnchor.constraint(equalToConstant: 143)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    // MARK: - Factory Components
    private func createLabel(withText text: String,
                             fontSize: CGFloat = 17,
                             color: UIColor = .black,
                             weight: UIFont.Weight = .regular) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.textColor = color
        return label
    }
    
}

@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    HomeView()
})
