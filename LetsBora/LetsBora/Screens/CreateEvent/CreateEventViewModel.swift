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
    private let notificationRepository: NotificationRepository
    
    private(set) var users: [User] = []
    
    init(
        eventRepository: EventRepository = FirestoreEventRepository(),
        userRepository: UserRepository = FirestoreUserRepository(),
        tagRepository: TagRepository = FirestoreTagRepository(),
        notificationRepository: NotificationRepository = FirestoreNotificationRepository()
    ) {
        self.eventRepository = eventRepository
        self.userRepository = userRepository
        self.tagRepository = tagRepository
        self.notificationRepository = notificationRepository
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
        Task {
            let usersToInvite: [User]? = event.participants
            guard let usersToInvite = usersToInvite else { return }
            for user in usersToInvite {
                do {
                    try await sendInvites(event: event, invitedUser: user)
                } catch {
                    print("Failed to send in invite for : \(user.name) error description:  \(error.localizedDescription))")
                }
            }
        }
    }
    func sendInvites(event: Event, invitedUser: User) async throws -> Void {
        let notificationID:String? = invitedUser.notificationID
        var notification: Notification? = nil
        
        if (notificationID == nil) {
            notification = Notification()
            guard let notification = notification else {
                return
            }
            
            try await notificationRepository.create(notification)
            var updatedUser = invitedUser
            updatedUser.notificationID = notification.id
            try await updateUser(user: updatedUser)
            
        } else {
            guard let notificationID = notificationID else {
                return
            }
            notification = try await notificationRepository.retrieve(for: notificationID)
        }
        
        // create the message
        guard let sender = Utils.getLoggedInUser() else {
            return
        }
        
        let message: MessageNotification = .init(
            text: "\(sender.name) invite to a new Event called \(event.title)",
            senderID: sender.id,
            eventID: event.id
        )
        
        guard var notification = notification else { return }
        notification.addMessage(message)
        
        try await notificationRepository.update(notification)
        
    }
    

    private func updateUser(user: User) async throws -> Void {
        try await userRepository.update(user)
    }
    
    func getUserToInvite() async -> [User] {
        var users: [User] = []
        do {
            users = try await userRepository.retrieveAll()
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            return []
        }
        let userId = Utils.getLoggedInUser()?.id
        
        if let userId = userId {
            users.removeAll { $0.id == userId }
        }
        
        return users
    }
}
