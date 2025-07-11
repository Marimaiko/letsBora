//
//  ChatGroup.swift
//  LetsBora
//
//  Created by Davi Paiva on 11/07/25.
//
import Foundation
struct ChatGroup: Codable {
    var id: String = UUID().uuidString
    var messages: [Chat] = []
}
