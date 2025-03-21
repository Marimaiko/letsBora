//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - UI Components
    lazy var titleLabel = createLabel(withText: "Let's Bora",fontSize: 48)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    private func setHierarchy(){
        self.view.addSubview(titleLabel)
    }
    private func setConstraints(){
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Factory Components
    private func createLabel(withText text: String, fontSize: CGFloat = 17, weight: UIFont.Weight = .regular) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .black
        return label
    }
    
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    HomeViewController()
})
