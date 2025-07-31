//
//  NotificationViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/07/25.
//

class NotificationViewModel {
    var notificationGroup: Notification?
    private let userRepository: UserRepository
    private let notificationRepository: NotificationRepository
    
    
    var numberOfNotifications: Int {
        return notificationGroup?.totalCount ?? 0
    }
    
    func getNotificationByIndex(_ index: Int) -> MessageNotification? {
        return notificationGroup?.messages[index] ?? nil
    }

    init(
        notificationRepository: NotificationRepository = FirestoreNotificationRepository(),
        userRepository: UserRepository = FirestoreUserRepository()
    ) {
        self.notificationRepository = notificationRepository
        self.userRepository = userRepository
    }
    
    func loadNotifications() async throws {
        guard let id = Utils.getLoggedInUser()?.id else {
            print("Failed to Retrieve user Id from Default User")
            return
        }
        
        do {
            let user = try await userRepository.retrieve(for: id)
            Utils.saveLoggedInUser(user)
            
            guard let notificationID = user.notificationID else {
                print("No notification ID found for user")
                return
            }
            print("Search for notificationID = \(notificationID)")
            
            self.notificationGroup = try await notificationRepository.retrieve(for: notificationID)
            
        } catch {
            print("Failed to Load Notifications: \(error.localizedDescription)")
        }
    }
}
