//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - UI Components
    private lazy var titleLabel = createLabel(withText: "Let's Bora",fontSize: 48)
    private lazy var yourNextEventLabel = createLabel(withText: "Seu próximo rolê",fontSize: 24)
    
    private lazy var tagLabel: UILabel =  createLabel(withText: "Particular",
                                                      fontSize: 10,
                                                      color: .white,
                                                      weight: .bold)
    private lazy var eventDescriptionLabel: UILabel =  createLabel(
                                                                withText: "Aniversário do João",
                                                                fontSize: 18, weight: .bold)
    private lazy var localEventLabel: UILabel = createLabel(withText: "Casa do João", fontSize: 14, color: .darkGray, weight: .light)
    
    private lazy var tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
        view.addSubview(tagLabel)
        NSLayoutConstraint.activate([
            tagLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tagLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tagLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tagLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            tagLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
        ])
        return view
    }()
    
    
    private lazy var yourNextEventStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tagView, eventDescriptionLabel,localEventLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        

        return stackView
    }()

    // Wrap the stack view inside a container for styling
    private lazy var yourNextEventContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.cornerRadius = 24
        container.layer.borderColor = UIColor.black.cgColor

        // Apply drop shadow to the container
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.25
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 4

        // Add stackView inside the container
        container.addSubview(yourNextEventStackView)

        NSLayoutConstraint.activate([
            yourNextEventStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            yourNextEventStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            yourNextEventStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -140),
            yourNextEventStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])

        return container
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        setHierarchy()
        setConstraints()
        self.view.backgroundColor = .systemGray6
    }
    private func setHierarchy(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(yourNextEventLabel)
        self.view.addSubview(yourNextEventContainer)
    }
    
    private func setConstraints(){
        let constraints: [NSLayoutConstraint] = [
            // title constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            // your Next Event Label  contraint
            yourNextEventLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 44),
            yourNextEventLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            yourNextEventLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            // yourNextEventContainer constraints
            yourNextEventContainer.topAnchor.constraint(equalTo: yourNextEventLabel.bottomAnchor, constant: 15),
            yourNextEventContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            yourNextEventContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            yourNextEventContainer.heightAnchor.constraint(equalToConstant: 143),
            
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

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})
@available(iOS 17.0, *)
#Preview("Your Next Event",
         traits:.sizeThatFitsLayout,
         body: {
    HomeViewController().view.subviews[2]
})
