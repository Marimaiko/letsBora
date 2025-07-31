//
//  NotificationDetailViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 31/07/25.
//

class NotificationDetailViewModel {
    private var userRepository: UserRepository
    private var notificationRepository: NotificationRepository
    private var eventRepository: EventRepository
    
    private var notificationGroup: Notification
    private var index: Int
    
    var message: MessageNotification {
        return notificationGroup.messages[index]
    }
    
    init(
        notification: Notification,
        index: Int,
        userRepository: UserRepository = FirestoreUserRepository(),
        notificationRepository: NotificationRepository = FirestoreNotificationRepository(),
        eventRepository: EventRepository = FirestoreEventRepository()
    ) {
        self.notificationGroup = notification
        self.index = index
        self.userRepository = userRepository
        self.notificationRepository = notificationRepository
        self.eventRepository = eventRepository
        
    }
    func getEvent() async -> Event? {
        guard let eventID = message.eventID else {
            print("No event ID provided")
            return nil
        }
        
        do {
            let event = try await eventRepository.retrieve(for: eventID)
            return event
        } catch {
            print("Failed to retrieve Event \(error.localizedDescription)")
            return nil
        }
        
    }
    func markAsReaded() async -> Void {
        notificationGroup.setAsReaded(index: index)
        do {
            try await notificationRepository.update(notificationGroup)
        } catch {
            print("Failed to update notification: \(error.localizedDescription)")
        }
        
        
    }
    func getSender() async -> User? {
        guard let senderID = message.senderID else {
            print("sender ID not providedd")
            return nil
        }
        do {
            let user = try await userRepository.retrieve(for: senderID)
            return user
        } catch {
            print("Failed to get Sender \(error.localizedDescription)")
            return nil
        }

    }
}
