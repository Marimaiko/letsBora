//
//  CategoryViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 06/06/25.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private var availableOptions: [Tag]?
    private var initialOption: Tag?
    private var selectedOption: Tag?
    var onSelectCategory: ((Tag) -> Void)?
    
    init(
        option: [Tag]? = nil,
        initialOption: Tag? = nil
    ) {
        self.availableOptions = option
        self.initialOption = initialOption
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupPicker()
    }
    func setupPicker(){
        let options = availableOptions?.map { $0.title } ?? []
        let pickerView = ReusablePickerView(options: options) { [weak self] selected in
            self?.selectedOption = self?.availableOptions?.first(
                where: { $0.title == selected }
            )
        }
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        if let initialOption = initialOption?.title {
            pickerView.selectInitialValue(options.firstIndex(of: initialOption) ?? 0)
        } else {
            pickerView.selectInitialValue(0)
        }
    }
    func setupNavigationBar() {
        navigationItem.title = "Selecionar Categoria"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(handleDone)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancelar",
            style: .plain,
            target: self,
            action: #selector(handleCancel)
        )
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    @objc func handleDone() {
        guard let selectedOption,
              let onSelectCategory else {
            return
        }
        
        onSelectCategory(selectedOption)
        dismiss(animated: true)
    }
    
    
}
