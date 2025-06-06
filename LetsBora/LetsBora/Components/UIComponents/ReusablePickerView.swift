//
//  ReusablePickerView.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/06/25.
//

import UIKit

final class ReusablePickerView: UIView {

    // MARK: - Properties
    private let pickerView = UIPickerView()
    private var options: [String]
    private var onSelect: ((String) -> Void)?
    
    // MARK: - Init
    init(options: [String], onSelect: @escaping (String) -> Void) {
        self.options = options
        self.onSelect = onSelect
        super.init(frame: .zero)
        setupPicker()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func selectInitialValue(_ index: Int = 0) {
        guard options.indices.contains(index) else { return }
        pickerView.selectRow(index, inComponent: 0, animated: false)
        onSelect?(options[index])
    }
}

// MARK: - UIPickerView DataSource & Delegate
extension ReusablePickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        options.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onSelect?(options[row])
    }
}
