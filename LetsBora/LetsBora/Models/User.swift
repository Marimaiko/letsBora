//
//  User.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//
import Foundation
struct User: Identifiable {
    var id: String = UUID().uuidString
    var password: String?
    var email: String?
    var name: String
    var photo: String? // will be url after
}

