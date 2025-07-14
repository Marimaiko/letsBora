//
//  EventDetailsViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 11/04/25.
//

import Foundation
import MapKit
import UIKit

//TODO: Fazer separação com view model
class EventDetailsViewController: UIViewController {
    var screen: EventDetailsView?
    var viewModel: EventDetailViewModel?
    
    // Inicializador para injetar o evento
    init(event: Event) {
        viewModel = EventDetailViewModel(event: event)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func loadView() {
        screen = EventDetailsView()
        self.view = screen
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        screen?.delegate = self
        //screen?.configure(with: self.event)
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        guard let event = viewModel?.event else {return}
        screen?.configure(with: event)
        
        title = event.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
    }
    
    // MARK: - Maps Helper
    private func openAppleMaps() {
        guard let location = viewModel?.event.locationDetails else {
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
        guard let event = viewModel?.event else { return }
        let editVM = EditEventViewModel(event: event)
        let editViewController = EditEventViewController(viewModel: editVM)
        
        editViewController.onDismissAndUpdate = { [weak self] updatedEvent in
            guard let self = self else { return }
            viewModel?.updateEvent(updatedEvent)
            screen?.showUpdateToast(message: "Evento atualizado com sucesso!")
        }
        
        navigationController?.pushViewController(editViewController, animated: true)
    }
}

extension EventDetailsViewController: EventDetailsViewDelegate {
    func barButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case EventDetailsView.TabTag.chat.rawValue:
            Task{
                await viewModel?.openChat()
                guard let chat = viewModel?.chat else {return}
                // TODO: PASS CHAT TO VIEWMODEL CHATVIEW
                navigationController?.pushViewController(
                    ChatViewController(with: chat),
                    animated: true
                )
            }
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
