//
//  EditEventDetailsViewModel.swift
//  LetsBora
//
//  Created by Mariana Maiko on 30/05/25.
//
import Foundation

final class EditEventViewModel {
    private(set) var event: Event
    
    init(event: Event) {
        self.event = event
    }
        
    func updateEvent(
        title: String?,
        date: String?,
        location: String?,
        description: String?,
        totalCost: String?
    ) {
        event.title = title ?? ""
        event.date = date ?? ""
        event.location = location ?? ""
        event.description = description ?? ""
        event.totalCost = totalCost ?? ""
    }
}
