//
//  TabBarController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 28/03/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    /// Sets up the tabs for the bar
    private func setupTabs() {
        // TODO: trocar as UIViewController pelas Controllers das telas
        let highlights = UINavigationController(rootViewController: UIViewController())
        let search = UINavigationController(rootViewController: UIViewController())
        let createEvent = UINavigationController(rootViewController: UIViewController())
        let myEvents = UINavigationController(rootViewController: UIViewController())
        let profile = UINavigationController(rootViewController: ProfileEditViewController())
        
        highlights.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), tag: 0)
        search.tabBarItem = UITabBarItem(title: "Buscar", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        createEvent.tabBarItem = UITabBarItem(title: "Criar Evento", image: UIImage(systemName: "plus.circle"), tag: 2)
        myEvents.tabBarItem = UITabBarItem(title: "Meus Eventos", image: UIImage(systemName: "heart"), tag: 3)
        profile.tabBarItem = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person"), tag: 4)
        
        self.viewControllers = [highlights, search, createEvent, myEvents, profile]
    }
    
    
}

// MARK: - Preview Profile
@available(iOS 17.0,*)
#Preview(traits: .portrait, body: {
    TabBarController()
})
