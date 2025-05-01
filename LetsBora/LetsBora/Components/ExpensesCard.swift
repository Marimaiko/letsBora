//
//  ExpensesCard.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 01/05/25.
//

import UIKit

class ExpenseCard: UIView{
    
    let imageSize: CGFloat = 40
    let fontSize: CGFloat = 16
    
    //MARK: Components
    private lazy var containerExpense: UIView = {
        let expenseView = UIView()
        expenseView.translatesAutoresizingMaskIntoConstraints = false
        expenseView.backgroundColor = .white
        expenseView.layer.cornerRadius = 8
        expenseView.layer.shadowColor = UIColor.black.cgColor
        expenseView.layer.shadowOpacity = 0.1
        expenseView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return expenseView
    }()
    
    private lazy var imageExpense: UIImageView = {
        let image = UIImageView(image: .add)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        return image
    }()
    
    private lazy var titleExpense: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Uber"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: fontSize)
        
        return title
    }()
    
    private lazy var descriptionExpense: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = "Corrida de Ida"
        description.textColor = .darkGray
        description.font = UIFont.systemFont(ofSize: fontSize)
        
        return description
    }()
    
    private lazy var valueExpense: UILabel = {
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.text = "R$50,00"
        value.textColor = .darkGray
        value.font = UIFont.systemFont(ofSize: 22)
        
        return value
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
extension ExpenseCard: ViewCode{
    func setHierarchy() {
        addSubview(containerExpense)
        containerExpense.addSubview(imageExpense)
        containerExpense.addSubview(titleExpense)
        containerExpense.addSubview(descriptionExpense)
        containerExpense.addSubview(valueExpense)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerExpense.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            containerExpense.heightAnchor.constraint(equalToConstant: 60),
            containerExpense.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerExpense.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            imageExpense.leadingAnchor.constraint(equalTo: containerExpense.leadingAnchor, constant: 10),
            imageExpense.centerYAnchor.constraint(equalTo: containerExpense.centerYAnchor),
            
            titleExpense.topAnchor.constraint(equalTo: containerExpense.topAnchor, constant: 10),
            titleExpense.leadingAnchor.constraint(equalTo: imageExpense.trailingAnchor, constant: 10),
            
            descriptionExpense.bottomAnchor.constraint(equalTo: containerExpense.bottomAnchor, constant: -10),
            descriptionExpense.leadingAnchor.constraint(equalTo: imageExpense.trailingAnchor, constant: 10),
            
            valueExpense.centerYAnchor.constraint(equalTo: containerExpense.centerYAnchor),
            valueExpense.trailingAnchor.constraint(equalTo: containerExpense.trailingAnchor, constant: -10)
            
        ])
    }
}

//MARK: -Preview
@available(iOS 17.0, *)
#Preview("ExpenseCard", traits: .sizeThatFitsLayout) {
    let expenseCard = ExpenseCard()
    expenseCard
}
