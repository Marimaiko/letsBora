//
//  ReusableTextView.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/06/25.
//
import UIKit

final class ReusableTextView: UITextView {
    
    private let placeholderLabel = UILabel()

    init(placeholder: String = "Digite aqui...", height: CGFloat = 120) {
        super.init(frame: .zero, textContainer: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isScrollEnabled = true
        self.textColor = .black
        self.font = .systemFont(ofSize: 16)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        

        // Add placeholder label
        placeholderLabel.text = placeholder
        placeholderLabel.font = .systemFont(ofSize: 16)
        placeholderLabel.textColor = .systemGray2
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ])

        // Set initial height
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// The didMoveToWindow() method is automatically called when the UITextView is added to a window
    /// (i.e., when it becomes part of the visible view hierarchy).
    override func didMoveToWindow() {
           super.didMoveToWindow()
           self.delegate = self
           placeholderLabel.isHidden = !text.isEmpty
       }
    
    func setText(_ text: String) {
        self.text = text
        placeholderLabel.isHidden = !text.isEmpty
    }
}

// MARK: - UITextViewDelegate

extension ReusableTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
