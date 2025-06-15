//
//  MyEventViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 15/06/25.
//
import Foundation

class MyEventViewModel {
    
    // MARK: - Attributes
    private var eventRepository: EventRepository?
    
    // MARK: - Initializer
    init(eventRepository: EventRepository? = FirestoreEventRepository()) {
        self.eventRepository = eventRepository
    }
    // MARK: - Helpers
    private var userId: String? = {
        let user = Utils.getLoggedInUser()
        return user?.id
    }()
    // MARK: - Load Events with Closure
    func loadEvents(completion: @escaping ([Event]) -> Void) {
        Task {
            do {
                let events = try await self.fetchMyEvents()
                DispatchQueue.main.async {
                    completion(events)
                }
            } catch {
                print("Error: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    private func fetchMyEvents() async throws -> [Event]{
        guard let userId = self.userId else {
            print("User ID not found")
            return []
        }
        let query: EventQuery = .init(
            key: EventKeys.owner,
            value: userId
        )
        
        return try await self.eventRepository?.retrieveEqual(query) ?? []
    }
    
    
}
