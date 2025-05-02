//
//  Chat.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

enum MessageType {
    case notification
    case message
    case survey
}

struct Chat {
    var type: MessageType
    var text: String
    var desciption:  String?
    var user: User?
    var activeOwner: Bool?
    var date: String?
    var seen: Bool?
    var survey: [Survey]?
}
