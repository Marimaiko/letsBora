//
//  Event.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//

import Foundation

struct Event {
    var title: String
    var image: String?
    var category: Category
    var visibility: String
    var date: String
    var location: String
    var participants: [User]
    var owner: User
}
