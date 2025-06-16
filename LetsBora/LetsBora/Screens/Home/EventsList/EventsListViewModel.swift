//
//  EventsListViewModel.swift
//  LetsBora
//
//  Created by Joel Lacerda on 16/06/25.
//

import Foundation

class EventsListViewModel {
    private let eventRepository: EventRepository
    
    // Injeção de dependência para facilitar testes
    init(eventRepository: EventRepository = FirestoreEventRepository()) {
        self.eventRepository = eventRepository
    }
    
    /// Busca todos os eventos.
    func fetchPublicEvents() async -> [Event] {
        do {
            // Para buscar apenas eventos públicos, seu repositório precisaria de um método
            // que filtra por visibilidade. Usando o retrieveEqual que você já tem:
            // let query = EventQuery(key: "visibility", value: "Público")
            // return try await eventRepository.retrieveEqual(query)
            
            // Por enquanto, vamos buscar todos os eventos como exemplo.
            return try await eventRepository.retrieveAll()
        } catch {
            print("Erro ao buscar eventos públicos: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Busca eventos onde o usuário logado é o proprietário.
    func fetchUserEvents() async -> [Event] {
        // Precisamos do ID do usuário logado.
        guard let currentUser = Utils.getLoggedInUser() else {
            print("Usuário não está logado. Não é possível buscar 'Meus Eventos'.")
            return []
        }
        
        do {
            // Usamos o método retrieveEqual que você definiu para buscar eventos
            // onde o 'ownerId' corresponde ao ID do usuário logado.
            // Certifique-se de que o campo 'ownerId' existe no seu dicionário 'toDict' do Event.
            let query = EventQuery(key: "ownerId", value: currentUser.id)
            return try await eventRepository.retrieveEqual(query)
        } catch {
            print("Erro ao buscar eventos do usuário: \(error.localizedDescription)")
            return []
        }
    }
}
