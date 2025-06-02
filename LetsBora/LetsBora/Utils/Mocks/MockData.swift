//
//  EventMocks.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//
import Foundation
import UIKit

struct MockData {
    static var chats: [Chat]
    = [
        chat1,
        chat2,
        chat3,
        chat4,
        chat5,
        chat6,
        chat7
    ]
    static var users: [User]
    = [
        user1,
        user2,
        user3,
        user4,
        user5,
        user6
    ]
    
    static var events: [Event] = [
        eventMock1, eventMock2, eventMock3
    ] + pastEvents
    
    static var tags: [Tag]
    =  [
        tag1,
        tag2,
        tag3,
        tag4,
        tag5,
        tag6
    ]
}
