//
//  CostContainer.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 30/04/25.
//
import UIKit

class CostContainer: UIView{
    
    //MARK: Components
    private lazy var containerTotal: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return containerView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = ReusableLabel(text: "Total do Evento", labelType: .h4)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .darkGray
        
        return title
    }()
    
    private lazy var totalCost: UILabel = {
        let total = ReusableLabel(text: "R$ 1.250,00", labelType: .h1)
        total.translatesAutoresizingMaskIntoConstraints = false
        
        return total
    }()
    
    private lazy var costForPerson: UILabel = {
        let forPerson = ReusableLabel(text: "R$ 125,00 por pessoa", labelType: .h4)
        forPerson.translatesAutoresizingMaskIntoConstraints = false
        forPerson.textColor = .darkGray
        
        return forPerson
    }()
    
    //MARK: Init
    init(){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Hierarchy/Constraints
extension CostContainer: ViewCode {
    func setHierarchy() {
        addSubview(containerTotal)
        containerTotal.addSubview(titleLabel)
        containerTotal.addSubview(totalCost)
        containerTotal.addSubview(costForPerson)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerTotal.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerTotal.heightAnchor.constraint(equalToConstant: 146),
            containerTotal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerTotal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: containerTotal.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: containerTotal.centerXAnchor),
            
            totalCost.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            totalCost.centerXAnchor.constraint(equalTo: containerTotal.centerXAnchor),
            
            costForPerson.topAnchor.constraint(equalTo: totalCost.bottomAnchor, constant: 16),
            costForPerson.centerXAnchor.constraint(equalTo: containerTotal.centerXAnchor),
        ])
    }
}

//MARK: -Preview
@available(iOS 17.0, *)
#Preview("CostContainerView", traits: .sizeThatFitsLayout) {
    let costContainer = CostContainer()
    costContainer
}
