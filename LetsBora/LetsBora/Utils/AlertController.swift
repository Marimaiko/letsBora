//
//  AlertController.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//

import UIKit

class AlertController {
    var  controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showAlert(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil // <-- adicione o callback opcional
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default){ _ in
            completion?()
        })
        
        controller.present(alertController, animated: true)
    }
}
