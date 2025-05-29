//
//  AuthUser.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//

struct AuthUser {
    var email: String
    var password: String
}

struct AuthUserResponse: Codable {
    var uid: String
}
