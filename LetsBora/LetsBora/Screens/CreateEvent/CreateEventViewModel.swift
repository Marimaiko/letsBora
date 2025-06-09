//
//  CreateEventViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

class CreateEventViewModel {
    private let eventRepository: EventRepository
    private let userRepository: UserRepository
    private let tagRepository: TagRepository
    
    private(set) var users: [User] = []
    
    init(
        eventRepository: EventRepository = FirestoreEventRepository(),
        userRepository: UserRepository = FirestoreUserRepository(),
        tagRepository: TagRepository = FirestoreTagRepository()
    ) {
        self.eventRepository = eventRepository
        self.userRepository = userRepository
        self.tagRepository = tagRepository
    }
    
    func getTags() async -> [Tag] {
        let tags =  await fetchTags()
        return tags
    }
    
    private func fetchTags() async -> [Tag] {
        do {
            return try await tagRepository.retrieveAll()
        } catch {
            print("Error fetching tags: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveEvent(event:Event) async throws ->Void {
        do {
            try await eventRepository.create(event)
            print("Event saved successfully: \(event)")
        } catch {
            print("Error saving event: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchUsers() async -> [User] {
        
        do {
            return try await userRepository.retrieveAll()
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        return []
        }
        
    }
    
    
}
