//
//  CustomContainer.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 29/04/25.
//
import UIKit
enum ContainerType{
    case date, location, category
}

protocol CustomContainerDelegate: AnyObject{
    func containerTapped(type: ContainerType)
}

class CustomContainer: UIView{
    
    weak var delegate: CustomContainerDelegate?
    var containerType: ContainerType
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 16
    var iconName: String
    var labelName: String
    var arrowName: String
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.layer.borderWidth = 0.5
        container.layer.cornerRadius = 5
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        container.addGestureRecognizer(tapGesture)
        
        return container
    }()
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .black
        icon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        icon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        return icon
    }()
    
    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = labelName
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var arrowView: UIImageView = {
        let arrowIcon = UIImageView(image: UIImage(systemName:arrowName))
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        arrowIcon.contentMode = .scaleAspectFit
        arrowIcon.tintColor = .gray
        
        return arrowIcon
    }()
    
    // MARK: - Init
    init(iconName: String, labelName: String, arrowName: String, type: ContainerType) {
        self.iconName = iconName
        self.labelName = labelName
        self.arrowName = arrowName
        self.containerType = type
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showCalendar() {
        self.delegate?.containerTapped(type: self.containerType)
    }
}

extension CustomContainer: ViewCode {
    func setHierarchy() {
        self.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(labelView)
        containerView.addSubview(arrowView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 24 + iconSize),
            
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            labelView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
            labelView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            arrowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            arrowView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

//MARK: -Preview
@available(iOS 17.0, *)
#Preview("CustomContainerView", traits: .sizeThatFitsLayout) {
    let dateContainer = CustomContainer(iconName: "calendar", labelName: "Teste", arrowName: "chevron.right", type: .date)
    dateContainer
}
