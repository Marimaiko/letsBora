//
//  User.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//
import Foundation
struct User: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var email: String?
    var password: String? // only use in mock examples
    var photo: String? // will be url after
}

