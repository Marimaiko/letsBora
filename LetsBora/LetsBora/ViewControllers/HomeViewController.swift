//
//  HomeViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit
import SwiftUI
class HomeViewController: UIViewController {
    // MARK: - UI Components
    private lazy var titleLabel = createLabel(withText: "Let's Bora",fontSize: 48)
    private lazy var yourNextEventLabel = createLabel(withText: "Seu próximo rolê",fontSize: 24)
    
    lazy var eventCardView = EventCardView(
        title:"Aniversário do João",
        location:"Casa do João",
        tag: "Particular"
    )
    
    
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
        self.view.addSubview(eventCardView)
    }
    
    private func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
            // Title constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),

            // Your Next Event Label constraints
            yourNextEventLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 44),
            yourNextEventLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),

            // Event Card constraints
            eventCardView.topAnchor.constraint(equalTo: yourNextEventLabel.bottomAnchor, constant: 15),
            eventCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            eventCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
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

// MARK: - Preview Profile
#if compiler(>=5.9) // Ensures this runs only on Xcode 15+
@available(iOS 17.0, *)
#Preview("Home View Controller", traits: .portrait, body: {
    HomeViewController()
})

@available(iOS 17.0, *)
#Preview("Your Next Event",
         traits: .sizeThatFitsLayout,
         body: {
    HomeViewController().view.subviews[safe: 2] // Avoids crashes if subviews[2] doesn't exist
})
#else

struct HomePreview_Previews: PreviewProvider{
    static var previews: some View {
        HomeViewController().showPreview()
            .previewDisplayName("Home View Controller")
    }
}

#endif
