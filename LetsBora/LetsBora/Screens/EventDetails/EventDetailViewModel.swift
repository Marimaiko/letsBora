//
//  EventDetailViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 02/07/25.
//

class EventDetailViewModel {
    var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    func updateEvent(_ event: Event) {
        self.event = event
    }
    
}
