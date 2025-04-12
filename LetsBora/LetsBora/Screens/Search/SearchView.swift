//
//  SearchView.swift
//  LetsBora
//
//  Created by Davi Paiva on 11/04/25.
//

import UIKit

class SearchView: UIView {
    // MARK: - UI Components
    private lazy var titleLabel = ReusableLabel(text: "Buscar", labelType: .title)
    private lazy var searchEventTextField = createTextField(placeholder: "Digite o nome  do evento" )
    
    private let AllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "Todos"
        return button
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
    init(){
        super.init(frame: .zero)
        setupView()
        // Set light gray background color
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
    }
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Factory
    private func createTextField(placeholder: String, height: CGFloat = 40) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: height).isActive = true
        return textField
    }
}

// MARK: - View code setup
extension SearchView: ViewCode {
    func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(searchEventTextField)
        self.addSubview(AllButton)
        self.addSubview(tableView)
    }
    
    func setConstraints() {
        titleLabel
            .top(anchor: self.topAnchor, constant: 48)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
        
        searchEventTextField
            .top(anchor: titleLabel.bottomAnchor, constant: 8)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
        
        AllButton
            .top(anchor: searchEventTextField.bottomAnchor, constant: 8)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
        
        tableView
            .top(anchor: AllButton.bottomAnchor,constant: 8)
            .leading(anchor: self.leadingAnchor, constant: 16)
            .trailing(anchor: self.trailingAnchor, constant: -16)
            .bottom(anchor: self.bottomAnchor,constant: -16)
    }
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .sizeThatFitsLayout, body: {
    SearchView()
})
