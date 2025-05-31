//
//  User.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//
import Foundation

enum UserKeys {
    static let collectionName = "users"
    static let id = "userId"
    static let name = "name"
    static let email = "email"
    static let password = "password"
    static let photo = "photo"
    static let domain = "domain"
    static let createdAt = "createdAt"
}

struct User: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var email: String?
    var password: String? // only use in mock examples
    var photo: String? // will be url after

    
    init (
        id: String  = UUID().uuidString,
        name: String,
        email: String? = nil,
        password: String? = nil,
        photo: String? = nil,
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.photo = photo
    }
    
    init?(from data: [String: Any]) {
        // not optional attributes
        guard let id = data[UserKeys.id] as? String,
              let name = data[UserKeys.name] as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
        
        // optional attributes
        if let email = data[UserKeys.email] as? String {
            self.email = email
        }
        
        if let photo = data[UserKeys.photo] as? String {
            self.photo = photo
        }
        
     
    }
    
    var toDict: [String: Any] {
        var dict: [String: Any] = [
            UserKeys.id: id,
            UserKeys.name: name,
            UserKeys.createdAt: Date()
        ]
        if let email = email {
            dict[UserKeys.email] = email
        }
        if let photo = photo {
            dict[UserKeys.photo] = photo
        }
        
        return dict
    }
    
}

