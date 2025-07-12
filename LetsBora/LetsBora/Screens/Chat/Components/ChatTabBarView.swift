//
//  ChatTabBarView.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import UIKit
protocol ChatTabBarViewDelegate: AnyObject {
    func chatTabBarViewDidTapSendButton(_ chatTabBarView: ChatTabBarView)
    func chatTabBarViewDidTapMicrofoneButton(_ chatTabBarView: ChatTabBarView)
    func chatTabBarViewDidTapPlusButton(_ chatTabBarView: ChatTabBarView)
}
class ChatTabBarView: UIView {
    weak private var delegate: ChatTabBarViewDelegate?
    
    func delegate(_ delegate: ChatTabBarViewDelegate){
        self.delegate = delegate
    }
    
    struct InternalLayout {
        static let iconSize: CGFloat = 48
        static let marginHorizontal: CGFloat = 8
        static let marginVertical: CGFloat = 12
        static let containerHeight: CGFloat = iconSize + 2 * marginVertical
    }
    private var isSendButtonEnable: Bool = false {
        didSet {
            let config = UIImage.SymbolConfiguration(
                pointSize: InternalLayout.iconSize * 0.5,
                weight: .regular
            )
            if (isSendButtonEnable){
                print("set send button")
                rightBarItem.setImage(
                    UIImage(
                        systemName: "paperplane.fill",
                        withConfiguration: config
                    ),
                    for: .normal
                )
            } else {
                print("set microphone")
                rightBarItem.setImage(
                    UIImage(
                        systemName: "microphone.fill",
                        withConfiguration: config
                    ),
                    for: .normal
                )
            }
        }
    }
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var leftBarItem: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(
            pointSize: InternalLayout.iconSize * 0.5,
            weight: .regular
        )
        button.setImage(
            UIImage(
                systemName: "plus",
                withConfiguration: config
            ),
            for: .normal
        )
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var rightBarItem: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(
            pointSize: InternalLayout.iconSize * 0.5,
            weight: .regular
        )
        button.setImage(
            UIImage(
                systemName: "microphone.fill",
                withConfiguration: config
            ),
            for: .normal
        )
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite uma mensagem"
        textField.clipsToBounds = true
        
        // Add padding using left/right views
        let padding = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 12, height: 0)
        )
        textField.leftView = padding
        textField.leftViewMode = .always
        textField.rightView = padding
        textField.rightViewMode = .always
        
        // Style
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.opacity = 0.7
        textField.layer.cornerRadius = 8
        
        textField.backgroundColor = .clear
        
        return textField
    }()
    // MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        textField.delegate = self
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Behaviors
    @objc func didTapPlusButton(){
        
    }
    @objc func didTapButton(){
        isSendButtonEnable ?
        self.delegate?.chatTabBarViewDidTapSendButton(self) :
        self.delegate?.chatTabBarViewDidTapMicrofoneButton(self)
    }
    func getText() -> String {
        return textField.text ?? ""
    }
}
extension ChatTabBarView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        // Actual Text
        let currentText = textField.text ?? ""
        
        // Changed Text
        guard let stringRange = Range(range, in: currentText) else { return true }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Case: First character digited
        if currentText.isEmpty && !updatedText.isEmpty {
            self.isSendButtonEnable = true
        }
        
        // Case: erase last character and emptied the field
        if !currentText.isEmpty && updatedText.isEmpty {
            self.isSendButtonEnable = false
        }
        
        return true
    }
}
extension ChatTabBarView: ViewCode {
    func setHierarchy() {
        self.addSubview(container)
        
        container.addSubview(leftBarItem)
        container.addSubview(rightBarItem)
        container.addSubview(textField)
    }
    
    func setConstraints() {
        container
            .leading(anchor: self.leadingAnchor)
            .trailing(anchor: self.trailingAnchor)
            .bottom(anchor: self.bottomAnchor)
            .height(constant: InternalLayout.containerHeight)
        
        leftBarItem
            .leading(
                anchor: container.leadingAnchor,
                constant: InternalLayout.marginHorizontal
            )
            .top(
                anchor: container.topAnchor,
                constant: InternalLayout.marginVertical
            )
            .height(constant: InternalLayout.iconSize)
            .width(constant: InternalLayout.iconSize)
        
        rightBarItem
            .top(
                anchor: container.topAnchor,
                constant: InternalLayout.marginVertical
            )
            .trailing(
                anchor: container.trailingAnchor,
                constant: -InternalLayout.marginHorizontal
            )
            .height(constant: InternalLayout.iconSize)
            .width(constant: InternalLayout.iconSize)
        
        
        textField
            .top(
                anchor: container.topAnchor,
                constant: InternalLayout.marginVertical
            )
            .leading(
                anchor: leftBarItem.trailingAnchor,
                constant: InternalLayout.marginHorizontal
            )
            .trailing(
                anchor: rightBarItem.leadingAnchor,
                constant: -InternalLayout.marginHorizontal
            )
            .height(constant: InternalLayout.iconSize)
        
        
    }
    
    
}
// MARK: - Preview
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview("ChatTabBarView", traits: .sizeThatFitsLayout) {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = .systemBackground
    
    let chatView = ChatTabBarView()
    chatView.translatesAutoresizingMaskIntoConstraints = false
    
    container.addSubview(chatView)
    
    NSLayoutConstraint.activate([
        chatView.topAnchor.constraint(equalTo: container.topAnchor),
        chatView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        chatView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        chatView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
    
    container.layoutIfNeeded()
    return container
    
    
}
#endif
