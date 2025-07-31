//
//  HomeViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

import Foundation

class HomeViewModel {
    
    private let eventRepository: EventRepository
    private let notificationRepository: NotificationRepository
    private let userRepository: UserRepository
    
    init(
        eventRepository: EventRepository = FirestoreEventRepository(),
        notificationRepository: NotificationRepository = FirestoreNotificationRepository(),
        userRepository: UserRepository = FirestoreUserRepository()
    ) {
        self.eventRepository = eventRepository
        self.notificationRepository = notificationRepository
        self.userRepository = userRepository
    }
    func hasNotification() async -> Bool {
        return await getNotificationCount() > 0
    }
    

    private func getNotificationCount() async -> Int {
        guard let userId = Utils.getLoggedInUser()?.id else {
            return 0
        }
        do {
            
            let user = try await userRepository.retrieve(for: userId)
            Utils.saveLoggedInUser(user)
            
            guard let notificationId = user.notificationID else {
                return 0
            }
        
            let notification = try await notificationRepository.retrieve(for: notificationId)
            guard let notification = notification else {
                return 0
            }
            return notification.unreadCount
        } catch {
            return 0
        }
    }
    /// Busca todos os eventos e os separa em "próximo evento" e "destaques".
    func fetchFutureEvents() async -> [Event] {
        do {
            let publicEventsQuery = EventQuery(key: EventKeys.visibility, value: "Público")
            let publicEvents = try await eventRepository.retrieveEqual(publicEventsQuery)
            
            // Filtra apenas eventos futuros
            let futureEvents = publicEvents.filter { event in
                // Se a conversão falhar, considera a data como uma data no passado distante
                guard let eventDate = event.date.toDate() else {
                    return false
                }
                return eventDate >= Date()
            }
            
            // Ordena os eventos futuros por data, do mais próximo para o mais distante
            let sortedFutureEvents = futureEvents.sorted { event1, event2 in
                guard let date1 = event1.date.toDate(),
                      let date2 = event2.date.toDate() else {
                    return false
                }
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
