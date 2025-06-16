//
//  HomeViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

import Foundation

class HomeViewModel {
    
    private let eventRepository: EventRepository
    
    // O resultado da busca de eventos, já separado.
    typealias FetchedEvents = (highlighted: Event?, list: [Event])
    
    init(eventRepository: EventRepository = FirestoreEventRepository()) {
        self.eventRepository = eventRepository
    }
    
    /// Busca todos os eventos e os separa em "próximo evento" e "destaques".
    func fetchAndDistributeEvents() async -> FetchedEvents {
        do {
            let allEvents = try await eventRepository.retrieveAll()
            
            // Filtra apenas eventos futuros
            let futureEvents = allEvents.filter { $0.date >= Date() }
            
            // Ordena os eventos futuros por data, do mais próximo para o mais distante
            let sortedFutureEvents = futureEvents.sorted { $0.date < $1.date }
            
            // O primeiro da lista ordenada é o nosso evento de destaque ("próximo rolê")
            let highlightedEvent = sortedFutureEvents.first
            
            var listEvents: [Event] = []
            
            if highlightedEvent != nil {
                // A lista de "destaques" contém os outros eventos futuros
                listEvents = Array(sortedFutureEvents.dropFirst())
            }
            
            return (highlighted: highlightedEvent, list: listEvents)
            
        } catch {
            print("Erro ao buscar e distribuir eventos no HomeViewModel: \(error.localizedDescription)")
            // Retorna tupla vazia em caso de erro
            return (highlighted: nil, list: [])
        }
    }
}
