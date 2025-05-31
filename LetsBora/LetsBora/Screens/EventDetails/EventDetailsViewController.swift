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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editTapped)
        )
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
    
    // MARK: - Actions
    @objc func editTapped() {
        let editVC = EditEventViewController()
        editVC.onSave = { [weak self] date, place, address, description, cost in
            self?.eventDetailsView.updateDate(date)
            self?.eventDetailsView.updateLocation(place, address: address)
            self?.eventDetailsView.updateDescription(description)
            self?.eventDetailsView.updateCost(cost)
        }
        navigationController?.pushViewController(editVC, animated: true)
    }
}

extension EventDetailsViewController: EventDetailsViewDelegate {
    func barButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case EventDetailsView.TabTag.chat.rawValue:
            navigationController?.pushViewController(ChatViewController(), animated: true)
        case EventDetailsView.TabTag.costs.rawValue:
            navigationController?.pushViewController(CostControlViewController(), animated: true)
        case EventDetailsView.TabTag.maps.rawValue:
            openAppleMaps()
        default:
            break
        }
    }
}
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    EventDetailsViewController()
})
#endif
