//
//  Notification.swift
//  LetsBora
//
//  Created by Davi Paiva on 24/07/25.
//

import Foundation
enum NotificationKeys {
    static let collectionName: String = "notifications"
}

struct Notification: Codable {
    var id: String
    var messages: [MessageNotification]
    var unreadCount: Int
    var totalCount: Int
    
    init(
        id: String = UUID().uuidString,
        messages: [MessageNotification] = [],
        unreadCount: Int = 0,
        totalCount: Int = 0
    ) {
        self.id = id
        self.messages = messages
        self.unreadCount = unreadCount
        self.totalCount = totalCount
    }
    
    mutating func addMessage(_ message: MessageNotification) {
        messages.insert(message, at: 0)
        totalCount += 1
        if !message.isRead {
            unreadCount += 1
        }
    }
    mutating func setAsReaded(index: Int){
        if(!messages[index].isRead){
            messages[index].isRead = true
            unreadCount -= 1
        }
    }
}

struct MessageNotification: Codable {
    var title: String
    var text: String
    var isRead: Bool
    var createdAt: Date
    var senderID: String?
    var chatID: String?
    var eventID: String?
    
    init(
        title: String,
        text: String,
        isRead: Bool = false,
        createdAt: Date = Date(),
        senderID: String? = nil,
        chatID: String? = nil,
        eventID: String? = nil
    ) {
        self.title = title
        self.text = text
        self.isRead = isRead
        self.createdAt = createdAt
        self.senderID = senderID
        self.chatID = chatID
        self.eventID = eventID
    }
}
