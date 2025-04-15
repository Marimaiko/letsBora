//
//  ConquerView.swift
//  LetsBora
//
//  Created by Mariana Maiko on 14/04/25.
//
import UIKit

enum ConquestType {
    case expert
    case popular
    case topHost
    
    var title: String {
        switch self {
        case .expert: return "Expert"
        case .popular: return "Popular"
        case .topHost: return "Top Host"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .expert:
            return UIImage(named: "expert-icon")
        case .popular:
            return UIImage(named: "popular-icon")
        case .topHost:
            return UIImage(named: "tophost-icon")
        }
    }
}

class ConquestIconView: UIView {
    private let iconImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = . center
        title.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        title.textColor = .black
        return title
    }()
    
    lazy private var stackview: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(type: ConquestType) {
        super.init(frame: .zero)
        buildView()
        setupConstraints()
        config(with: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        addSubview(stackview)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
     func config(with type: ConquestType) {
        iconImageView.image = type.icon
        titleLabel.text = type.title
        }
}
