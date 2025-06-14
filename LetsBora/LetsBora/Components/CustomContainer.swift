//
//  CustomContainer.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 29/04/25.
//
import UIKit
enum ContainerType{
    case date, location, category, privacity
}

protocol CustomContainerDelegate: AnyObject{
    func containerTapped(type: ContainerType)
}

class CustomContainer: UIView {
    
    weak var delegate: CustomContainerDelegate?
    var containerType: ContainerType
    let iconSize: CGFloat = 20
    let fontSize: CGFloat = 16
    var iconName: String
    var labelName: String
    
    
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
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
    
    private var rightView: UIView?
    
    private func createRightView(_ view: UIView) -> UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    // MARK: - Init
    init(iconName: String, labelName: String, arrowName: String, type: ContainerType) {
        
        self.iconName = iconName
        self.labelName = labelName
        self.containerType = type
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightView = createRightView(
            UIImageView(
                image: UIImage(
                    systemName: arrowName)
            )
        )
        
        setupView()
    }
    
    init(iconName: String, labelName: String, rightView: UIView, type: ContainerType){
        self.iconName = iconName
        self.labelName = labelName
        self.containerType = type
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightView = createRightView(rightView)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showCalendar() {
        self.delegate?.containerTapped(type: self.containerType)
    }
    
    // MARK: - Métodos públicos para atualizar e pegar o texto da label
    public func updateLabelName(newName: String) {
        self.labelView.text = newName
    }

    public func getLabelName() -> String? {
        return self.labelView.text
    }
    
    // MARK: - Ações
    @objc private func handleTap() {
        self.delegate?.containerTapped(type: self.containerType)
    }
}

extension CustomContainer: ViewCode {
    func setHierarchy() {
        self.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(labelView)
        
        if let rightView = rightView {
            containerView.addSubview(rightView)
        }
        
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
        ])
        
        if let rightView = rightView {
            NSLayoutConstraint.activate([
                rightView.trailingAnchor.constraint(
                    equalTo: containerView.trailingAnchor,
                    constant: -8
                ),
                rightView.centerYAnchor.constraint(
                    equalTo: containerView.centerYAnchor
                )
            ])
        }
        
    }
}

//MARK: -Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("CustomContainerView", traits: .sizeThatFitsLayout) {
    let dateContainer = CustomContainer(iconName: "calendar", labelName: "Teste", arrowName: "chevron.right", type: .date)
    dateContainer
}
#endif
