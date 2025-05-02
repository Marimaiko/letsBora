//
//  CostControlViewController.swift
//  LetsBora
//
//  Created by João VIctir da Silva Almeida on 29/04/25.
//

import UIKit

class CostControlViewController: UIViewController{
    
    var screen: CostControlView?
    
    override func loadView() {
        screen = CostControlView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    }
}

//MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    CostControlViewController()
})


