//
//  EditEventDetailsViewController.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/05/25.
//

import UIKit

class EditEventViewController: UIViewController, EditEventViewDelegate {

    private var screen = EditEventDetailsView()
    
    var onSave: ((_ date: String, _ place: String, _ address: String, _ description: String, _ cost: String) -> Void)?

    override func loadView() {
        screen.delegate = self
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Editar Evento"
    }
    
    func didTapSave() {
        let date = screen.dateTextField.text ?? ""
        let place = screen.locationTextField.text ?? ""
        let address = screen.addressTextField.text ?? ""
        let description = screen.descriptionTextView.text ?? ""
        let cost = screen.costTextField.text ?? ""

        if !place.isEmpty && address.isEmpty {
            let alert = UIAlertController(title: "Atenção",
                                          message: "Se você alterou o local, informe o novo endereço",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            onSave?(date, place, address, description, cost)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func didTapCancel() {
        dismiss(animated: true)
    }
}

