//
//  AuthUser.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//

struct AuthUser {
    // email auth
    var email: String?
    var password: String?
    
    // googleAuth
    var googleIDToken: String?
    var googleAccessToken: String?
}

struct AuthUserResponse: Codable {
    var uid: String
}
