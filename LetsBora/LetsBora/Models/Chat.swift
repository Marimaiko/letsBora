//
//  Chat.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

import Foundation
enum ChatKeys {
    static let collectionName: String = "chat"
}
enum MessageType: String, Codable {
    case notification
    case message
    case survey
}
struct Survey: Codable {
    var title: String
    var votes: String
}

struct Chat: Codable {
    var id: String = UUID().uuidString
    var type: MessageType
    var text: String
    var desciption:  String?
    var user: User?
    var activeOwner: Bool?
    var date: String?
    var seen: Bool?
    var survey: [Survey]?
}
