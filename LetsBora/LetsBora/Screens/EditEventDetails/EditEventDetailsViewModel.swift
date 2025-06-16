//
//  EditEventDetailsViewModel.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/05/25.
//

import Foundation
import CoreLocation

final class EditEventViewModel {
    private(set) var event: Event
    
    init(event: Event) {
        self.event = event
    }
        
    func updateEvent(
        title: String?,
        date: Date?,
        location: EventLocationDetails?,
        description: String?,
        totalCost: String?
    ) {
        if let newTitle = title, !newTitle.isEmpty { // Não atualizar para vazio se o campo for opcional
            event.title = newTitle
        }
               
        if let newDate = date {
            
            event.date = newDate.toString()
        }
               
        if let newLocation = location {
            event.locationDetails = newLocation
        }
        
        event.description = description // Se nil, a propriedade opcional será nil
        event.totalCost = totalCost     // Se nil, a propriedade opcional será nil
    }
}
