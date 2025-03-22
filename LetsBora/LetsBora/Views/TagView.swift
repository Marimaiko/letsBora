//
//  TagView.swift
//  LetsBora
//
//  Created by Davi Paiva on 21/03/25.
//

import UIKit

class TagView: UIView {

    private let label: UILabel

     init(text: String) {
         self.label = UILabel()
         super.init(frame: .zero)
         setupUI(text: text)
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func setupUI(text: String) {
         translatesAutoresizingMaskIntoConstraints = false
         backgroundColor = .black
         layer.cornerRadius = 12

         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = text
         label.textColor = .white
         label.font = .systemFont(ofSize: 10, weight: .bold)
         label.textAlignment = .center

         addSubview(label)

         NSLayoutConstraint.activate([
             label.centerXAnchor.constraint(equalTo: centerXAnchor),
             label.centerYAnchor.constraint(equalTo: centerYAnchor),
             label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
             label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
             label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
             label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
         ])
     }
}
