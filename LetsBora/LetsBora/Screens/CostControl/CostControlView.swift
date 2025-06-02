//
//  CostControlView.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 29/04/25.
//

import UIKit

class CostControlView: UIView{
    
    //MARK: Components
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var costContainer: CostContainer = {
        let container = CostContainer()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var expensesView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        
        let titleExpenses = ReusableLabel(text: "Despesas", labelType: .h4)
        titleExpenses.translatesAutoresizingMaskIntoConstraints = false
        titleExpenses.textColor = .darkGray
        containerView.addSubview(titleExpenses)
        
        let btShowMore = UIButton(type: .system)
        btShowMore.translatesAutoresizingMaskIntoConstraints = false
        btShowMore.setTitle("Ver Todas", for: .normal)
        btShowMore.setTitleColor(.systemBlue, for: .normal)
        btShowMore.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        containerView.addSubview(btShowMore)
        
        NSLayoutConstraint.activate([
            titleExpenses.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            titleExpenses.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            btShowMore.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            btShowMore.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
       
        return containerView
    }()
    
    private lazy var expensesCard1: ExpenseCard = {
        let card = ExpenseCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var expensesCard2: ExpenseCard = {
        let card = ExpenseCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var participantsView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        
        let titleParticipants = ReusableLabel(text: "Participantes", labelType: .h4)
        titleParticipants.translatesAutoresizingMaskIntoConstraints = false
        titleParticipants.textColor = .darkGray
        containerView.addSubview(titleParticipants)
        
        let btShowMore = UIButton(type: .system)
        btShowMore.translatesAutoresizingMaskIntoConstraints = false
        btShowMore.setTitle("Ver Todas", for: .normal)
        btShowMore.setTitleColor(.systemBlue, for: .normal)
        btShowMore.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        containerView.addSubview(btShowMore)
        
        NSLayoutConstraint.activate([
            titleParticipants.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            titleParticipants.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            btShowMore.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            btShowMore.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
       
        return containerView
    }()
    
    private lazy var participantCard1: ParticipantCard = {
        let card = ParticipantCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var participantCard2: ParticipantCard = {
        let card = ParticipantCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private lazy var buttonsContainer: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let btNewExpense = UIButton(type: .system)
        btNewExpense.translatesAutoresizingMaskIntoConstraints = false
        btNewExpense.setTitle("   + Nova Despesa   ", for: .normal)
        btNewExpense.setTitleColor(.white, for: .normal)
        btNewExpense.backgroundColor = .systemBlue
        btNewExpense.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btNewExpense.layer.cornerRadius = 8
        containerView.addSubview(btNewExpense)
        
        let btVouchers = UIButton(type: .system)
        btVouchers.translatesAutoresizingMaskIntoConstraints = false
        btVouchers.setTitle("Comprovantes", for: .normal)
        btVouchers.setTitleColor(.darkGray, for: .normal)
        btVouchers.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btVouchers.layer.cornerRadius = 8
        containerView.addSubview(btVouchers)
        
        NSLayoutConstraint.activate([
            btNewExpense.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            btNewExpense.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            btVouchers.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            btVouchers.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
       
        return containerView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Hierarchy e Constraints
extension CostControlView: ViewCode{
    func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(costContainer)
        contentView.addSubview(expensesView)
        contentView.addSubview(expensesCard1)
        contentView.addSubview(expensesCard2)
        contentView.addSubview(participantsView)
        contentView.addSubview(participantCard1)
        contentView.addSubview(participantCard2)
        contentView.addSubview(buttonsContainer)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            costContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            costContainer.heightAnchor.constraint(equalToConstant: 146),
            costContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            costContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            expensesView.topAnchor.constraint(equalTo: costContainer.bottomAnchor, constant: 48),
            expensesView.heightAnchor.constraint(equalToConstant: 40),
            expensesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            expensesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            expensesCard1.topAnchor.constraint(equalTo: expensesView.bottomAnchor, constant: 0),
            expensesCard1.heightAnchor.constraint(equalToConstant: 60),
            expensesCard1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            expensesCard1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            expensesCard2.topAnchor.constraint(equalTo: expensesCard1.bottomAnchor, constant: 16),
            expensesCard2.heightAnchor.constraint(equalToConstant: 60),
            expensesCard2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            expensesCard2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            participantsView.topAnchor.constraint(equalTo: expensesCard2.bottomAnchor, constant: 48),
            participantsView.heightAnchor.constraint(equalToConstant: 40),
            participantsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            participantsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            participantCard1.topAnchor.constraint(equalTo: participantsView.bottomAnchor, constant: 0),
            participantCard1.heightAnchor.constraint(equalToConstant: 60),
            participantCard1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            participantCard1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            participantCard2.topAnchor.constraint(equalTo: participantCard1.bottomAnchor, constant: 16),
            participantCard2.heightAnchor.constraint(equalToConstant: 60),
            participantCard2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            participantCard2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            buttonsContainer.topAnchor.constraint(equalTo: participantCard2.bottomAnchor, constant: 48),
            buttonsContainer.heightAnchor.constraint(equalToConstant: 40),
            buttonsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            buttonsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            buttonsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}
