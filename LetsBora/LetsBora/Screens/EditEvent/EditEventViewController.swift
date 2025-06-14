//
//  EditEventViewController.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 26/05/25.
//

import UIKit

class EditEventViewController: UIViewController{
    
    var screen: CreateEventView?

    override func loadView() {
        screen = CreateEventView(mode: .edit)
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CreateEventView(mode: .edit)
})
