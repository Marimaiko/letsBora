//
//  InMemoryEventRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

import Foundation

actor InMemoryEventRepository:EventRepository {
    func create(_ event: Event) async throws {
        MockData.events.append(event)
    }
    
    func retrieve(for id: String) async throws -> Event {
        let event = MockData.events.first(where: { $0.id == id })
        guard let event else {
            throw EventRepositoryError.eventNotFound
        }
        return event
    }
    
    func retrieveAll() async throws -> [Event] {
        guard !MockData.events.isEmpty else {
            throw EventRepositoryError.emptyData
        }
        return MockData.events
    }
    
    func update(_ event: Event) async throws {
        let id = event.id
        
        guard let index = MockData
            .events
            .firstIndex(
                where: {
                    $0.id == id
                }) else {
            throw EventRepositoryError.eventNotFound
        }
        MockData.events[index] = event
    }
    
    func delete(for id: String) async throws {
        
    }
    
    
}
