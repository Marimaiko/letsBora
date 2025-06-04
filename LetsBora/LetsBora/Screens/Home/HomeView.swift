//
//  HomeView.swift
//  LetsBora
//
//  Created by Davi Paiva on 26/03/25.
//

import UIKit

class HomeView: UIView {
    var delegate: HomeViewDelegate?
    
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(text: "Let's Bora", labelType: .title)
    private lazy var yourNextEventLabel = ReusableLabel(text: "Seu próximo rolê", labelType: .h2)
    private lazy var highlightEventLabel = ReusableLabel(text: "Destaques", labelType: .h2)
    
    private lazy var eventCardView1 : EventCardView = {
        let eventCard = EventCardView()
//        eventCard.setTitleLabel("Aniversário do João")
//        eventCard.setLocationLabel("Casa do João")
//        eventCard.setTagViewTextColor(text: "Particular")
//        eventCard.setDateLabel("15 jun.")
//        eventCard.setAvatars(["Jim", "John", "Julia"], 25)
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
        eventCardView1.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureNextEventCard(with event: Event) {
        eventCardView1.setTitleLabel(event.title)
        eventCardView1.setLocationLabel(event.locationDetails?.displayString ?? "Local não informado")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        eventCardView1.setDateLabel(event.date) // Assumindo event.date é Date
        
        if let tag = event.tag {
            eventCardView1.setTagViewTextColor(
                text: tag.title,
                textColor: UIColor(hex: tag.color),
                backgroundColor: UIColor(hex: tag.bgColor)
            )
        } else {
            // Lógica para ocultar ou mostrar uma tag padrão se não houver tag
            // eventCardView1.hideTagView() // Exigiria este método em EventCardView
        }
        if let imageName = event.image {
            eventCardView1.setImage(imageName)
        } else {
            // eventCardView1.removeImage() // Exigiria este método em EventCardView
        }
        if let participants = event.participants {
            let listOfNames = participants.prefix(3).map { $0.name }
            let extraCount = participants.count > 3 ? participants.count - 3 : 0
            eventCardView1.setAvatars(listOfNames, extraCount)
        } else {
            // eventCardView1.hideAvatars() // Exigiria este método em EventCardView
        }
        // Configurar outros aspectos do eventCardView1 se necessário
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
            .top(anchor: self.safeAreaLayoutGuide.topAnchor)
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
extension HomeView: EventCardViewDelegate {
    func didTapDetailButton(in view: EventCardView) {
        self.delegate?.seeDetailsTapped()
    }
    
}
// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("Home View ", traits: .portrait, body: {
    
    HomeViewController()
    
})
#endif
