//
//  NotificationDetailViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 31/07/25.
//

class NotificationDetailViewModel {
    private(set) var message: MessageNotification
    private var userRepository: UserRepository
    
    init(
        message: MessageNotification,
        userRepository: UserRepository = FirestoreUserRepository()
    ) {
        self.message = message
        self.userRepository = userRepository
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
