//
//  EventDetailsViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 11/04/25.
//

import Foundation
import MapKit
import UIKit

class EventDetailsViewController: UIViewController {
    // MARK: - UI Components
    let eventDetailsView = EventDetailsView()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func loadView() {
        self.view = eventDetailsView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        eventDetailsView.delegate = self
    }

    // MARK: - Setup
    private func setupNavigation() {
        // Set the title and button
        title = "Detalhes Aniversário do Pedro"
    }
    
    // MARK: - Maps Helper
    private func openAppleMaps() {
        // Endereço mockado na Avenida Paulista, São Paulo
        let latitude: CLLocationDegrees = -23.5632
        let longitude: CLLocationDegrees = -46.6542
        let placeName = "Casa do Pedro"
        
        // Criando a URL para abrir o Apple Maps
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        // Criando o item de mapa com as coordenadas e nome do local
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        
        // Abrindo o Maps com as opções definidas
        mapItem.openInMaps(launchOptions: options)
    }
}

extension EventDetailsViewController: EventDetailsViewDelegate {
    func barButtonTapped(_ sender: UIButton) {
        if(sender.tag == EventDetailsView.TabTag.chat.rawValue) {
            navigationController?.pushViewController(
                ChatViewController(),
                animated: true
            )
        }
        else if(sender.tag == EventDetailsView.TabTag.costs.rawValue) {
            navigationController?.pushViewController(
                CostControlViewController(),
                animated: true
            )
        }
        else if(sender.tag == EventDetailsView.TabTag.maps.rawValue) {
            // Abre o Apple Maps na localização mockada
            openAppleMaps()
        }
    }
}
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    EventDetailsViewController()
})
#endif
