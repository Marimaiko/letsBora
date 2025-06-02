//
//  CheckBoxButton.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//

import UIKit

class CheckboxButton: UIButton {

    // MARK: - Properties

    private(set) var isChecked: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setImage(UIImage(systemName: "square"), for: .normal)
        addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        tintColor = .systemBlue
    }

    // MARK: - Actions

    @objc private func toggleCheck() {
        isChecked.toggle()
    }

    // MARK: - Helpers

    private func updateAppearance() {
        let imageName = isChecked ? "checkmark.square.fill" : "square"
        setImage(UIImage(systemName: imageName), for: .normal)
    }

    // Optional: External toggle method
    func setChecked(_ checked: Bool) {
        isChecked = checked
    }
}
