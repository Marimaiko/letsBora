//
//  SearchViewModel.swift
//  LetsBora
//
//  Created by Joel Lacerda on 08/07/25.
//

import Foundation

class SearchViewModel {
    
    private let eventRepository: EventRepository
    private let tagRepository: TagRepository
    
    init(
        eventRepository: EventRepository = FirestoreEventRepository(),
        tagRepository: TagRepository = FirestoreTagRepository()
    ) {
        self.eventRepository = eventRepository
        self.tagRepository = tagRepository
    }
    
    /// Busca a lista inicial de tags para os filtros.
    func fetchTags() async -> [Tag] {
        do {
            return try await tagRepository.retrieveAll()
        } catch {
            print("Erro ao buscar tags: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Busca eventos com base em um texto e/ou uma tag selecionada.
    func searchEvents(withText searchText: String?, forTag tag: Tag?) async -> [Event] {
        do {
            var allFutureEvents: [Event] = []

            // Passo 1: Buscar um conjunto inicial de eventos.
            // Se uma tag for selecionada, filtramos por ela no backend.
            // Senão, buscamos todos os eventos públicos.
            if let selectedTag = tag {
                let query = EventQuery(key: EventKeys.tag, value: selectedTag.id)
                allFutureEvents = try await eventRepository.retrieveEqual(query)
            } else {
                let query = EventQuery(key: EventKeys.visibility, value: "Público")
                allFutureEvents = try await eventRepository.retrieveEqual(query)
            }
            
            // Passo 2: Filtrar por data (para mostrar apenas eventos futuros)
            let futureEvents = allFutureEvents.filter { event in
                guard let eventDate = event.date.toDate() else { return false }
                return eventDate >= Date()
            }
            
            // Passo 3: Se houver texto de busca, filtrar pelo título no lado do cliente.
            var filteredByTextEvents = futureEvents
            if let text = searchText, !text.isEmpty {
                filteredByTextEvents = futureEvents.filter { event in
                    // 'localizedCaseInsensitiveContains' faz uma busca "like" ignorando maiúsculas/minúsculas
                    return event.title.localizedCaseInsensitiveContains(text)
                }
            }
            
            // Passo 4: Ordenar o resultado final por data
            let sortedEvents = filteredByTextEvents.sorted { event1, event2 in
                guard let date1 = event1.date.toDate(), let date2 = event2.date.toDate() else { return false }
                return date1 < date2
            }
            
            return sortedEvents
            
        } catch {
            print("Erro ao buscar eventos no SearchViewModel: \(error.localizedDescription)")
            return []
        }
    }
}
