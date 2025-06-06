//
//  CalendarViewController.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/06/25.
//

import UIKit
class CalendarViewController: UIViewController {
    private var screen: CalendarView?
    private var initialDate: Date?
    var onSelectDate: ((Date) -> Void)?
    
    override func loadView() {
        if let initialDate = initialDate {
            screen = CalendarView(with: initialDate)
        } else {
            screen = CalendarView()
        }
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selecionar Data"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancelar",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(doneTapped)
        )
    }
    init(with date: Date?) {
        self.initialDate = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc func doneTapped() {
        guard let combinedDateAndTime = self.screen?.combinedDateAndTime,
              let onSelectDate else {
            return
        }
        onSelectDate(combinedDateAndTime)
        dismiss(animated: true)
    }
    
}
