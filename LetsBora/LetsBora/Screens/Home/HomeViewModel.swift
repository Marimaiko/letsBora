//
//  HomeViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

import Foundation

class HomeViewModel {
    
    private let eventRepository: EventRepository
    
    init(eventRepository: EventRepository = FirestoreEventRepository()) {
        self.eventRepository = eventRepository
    }
    
    /// Busca todos os eventos e os separa em "próximo evento" e "destaques".
    func fetchFutureEvents() async -> [Event] {
        do {
            let allEvents = try await eventRepository.retrieveAll()
            
            let dateFormatter = DateFormatter()
            // O formato PRECISA corresponder ao formato da sua string, ex: "dd MMM"
            dateFormatter.dateFormat = "dd MMM"
            dateFormatter.locale = Locale(identifier: "pt_BR")
            
            
            // Filtra apenas eventos futuros
            let futureEvents = allEvents.filter {
                // Se a conversão falhar, considera a data como uma data no passado distante
                let eventDate = dateFormatter.date(from: $0.date) ?? Date.distantPast
                return eventDate >= Date()
            }
            
            // Ordena os eventos futuros por data, do mais próximo para o mais distante
            let sortedFutureEvents = futureEvents.sorted {
                let date1 = dateFormatter.date(from: $0.date) ?? Date.distantPast
                let date2 = dateFormatter.date(from: $1.date) ?? Date.distantPast
                return date1 < date2
            }
            
            return sortedFutureEvents
            
        } catch {
            print("Erro ao buscar e distribuir eventos no HomeViewModel: \(error.localizedDescription)")
            // Retorna array vazio em caso de erro
            return []
        }
    }
}
