//
//  NotificationViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/07/25.
//

class NotificationViewModel {
    var notificationGroup: Notification

    var numberOfNotifications: Int {
        return notificationGroup.totalCount
    }
    
    func getNotificationByIndex(_ index: Int) -> MessageNotification {
        return notificationGroup.messages[index]
    }

    init() {
        self.notificationGroup = .init(
            messages: [
                .init(title: "Mensagem de Teste", text: "Texto de Teste")
            ],
            unreadCount: 1,
            totalCount: 1
        )
    }
    
}
