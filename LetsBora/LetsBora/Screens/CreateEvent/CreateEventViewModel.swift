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
        eventRepository: EventRepository = InMemoryEventRepository(),
        userRepository: UserRepository = InMemoryUserRepository(),
        tagRepository: TagRepository = FirestoreTagRepository()
    ) {
        self.eventRepository = eventRepository
        self.userRepository = userRepository
        self.tagRepository = FirestoreTagRepository()
    }
    
    func getTags() async -> [String] {
        let tags =  await fetchTags()
        
        var titleTags: [String] = []
        
        for tag in tags {
            titleTags.append(tag.title)
        }
        
        return titleTags
    }
    
    private func fetchTags() async -> [Tag] {
        do {
            return try await tagRepository.retrieveAll()
        } catch {
            print("Error fetching tags: \(error.localizedDescription)")
            return []
        }
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
