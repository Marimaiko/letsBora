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
    let eventDetailsView = EventDetailsView()
    var event: Event
    
    // Inicializador para injetar o evento
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        eventDetailsView.configure(with: self.event)
        title = self.event.title
    }
    override func loadView() {
        self.view = eventDetailsView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        eventDetailsView.delegate = self
        eventDetailsView.configure(with: self.event)
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        title = self.event.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
    }
    
    // MARK: - Maps Helper
    private func openAppleMaps() {
        guard let location = event.locationDetails else {
            print("Detalhes da localização não disponíveis para abrir no mapa.")
            // Opcional: Mostrar um alerta para o usuário
            let alert = UIAlertController(title: "Localização Indisponível", message: "Não há informações de coordenadas para este evento.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
                
        let coordinates = location.coordinates
        let placeName = location.name ?? location.address ?? "Local do Evento"
        
        let regionDistance: CLLocationDistance = 1000
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
    @objc func editButtonTapped() {
        let editVM = EditEventViewModel(event: self.event)
        let editViewController = EditEventViewController(viewModel: editVM)
        
        editViewController.onDismissAndUpdate = { [weak self] updatedEventFromEdit in
            guard let self = self else { return }
            self.event = updatedEventFromEdit // Atualiza o evento neste controller
            // self.eventDetailsView.configure(with: updatedEventFromEdit) // viewWillAppear já faz isso
            // self.title = updatedEventFromEdit.title // viewWillAppear já faz isso
            self.eventDetailsView.showUpdateToast(message: "Evento atualizado com sucesso!")
        }
        
        navigationController?.pushViewController(editViewController, animated: true)
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
    
    func editTapped() {
        self.editButtonTapped()
    }
}
#if swift(>=5.9)
@available(iOS 17.0, *)
#Preview(traits: .portrait, body: {
    // Crie um evento mock aqui usando a struct Event atualizada
    let mockEvent = Event(
        title: "Aniversário do Pedro (Preview)",
        image: "event-sample-image",
        tag: .init(title: "Festa", color: .white, bgColor: .blue), // Ajuste Tag conforme sua struct
        visibility: "Público",
        date: Date(), // Use uma data real
        locationDetails: .init(name: "Casa do Pedro (Preview)", address: "Rua Fictícia, 123", latitude: -23.5632, longitude: -46.6542),
        description: "Uma festa de aniversário para o Pedro.",
        totalCost: "Grátis",
        participants: [User(name: "Amigo 1")], // Supondo que User(name:) exista
        owner: User(name: "Pedro")
    )
    let navController = UINavigationController(rootViewController: EventDetailsViewController(event: mockEvent))
    return navController
})
#endif
