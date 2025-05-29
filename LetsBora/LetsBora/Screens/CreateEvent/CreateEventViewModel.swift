//
//  CreateEventViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

class CreateEventViewModel {
    private let eventRepository: EventRepository
    private let userRepository: UserRepository
    
    private(set) var users: [User] = []
    
    init(
        eventRepository: EventRepository = InMemoryEventRepository(),
        userRepository: UserRepository = InMemoryUserRepository()
    ) {
        self.eventRepository = eventRepository
        self.userRepository = userRepository
    }
    
    func saveEvent(event:Event) async {
        do {
            try await eventRepository.create(event)
            print("Event saved successfully: \(event)")
        } catch {
            print("Error saving event: \(error.localizedDescription)")
        }
    }
    
    func fetchUsers() async {
        do {
            self.users = try await userRepository.retrieveAll()
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
    
}
