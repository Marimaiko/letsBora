//
//  Event.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//

import Foundation
import FirebaseFirestore

enum EventKeys {
    static let collectionName: String = "events"
    static let id: String = "id"
    static let title: String = "title"
    static let image: String = "image"
    static let tag: String = "tag"
    static let visibility: String = "visibility"
    static let date: String = "date"
    static let locationDetails: String = "location"
    static let description: String = "description"
    static let totalCost: String = "totalCost"
    static let participants: String = "participants"
    static let owner: String = "owner"
}

struct Event: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var image: String?
    var tag: Tag? // update to reference
    var visibility: String?
    var date: Date
    var locationDetails: EventLocationDetails?
    var description: String?
    var totalCost: String?
    var participants: [User]? // update to reference
    var owner: User? // update to reference
    
    var toDict: [
        String: Any
    ] {
        var dict: [String: Any] = [
            EventKeys.id: id,
            EventKeys.title: title,
            EventKeys.date: Timestamp(date: self.date),
            EventKeys.locationDetails: locationDetails?.toDict ?? ""
        ]
        
        if let image = image {
            dict[EventKeys.image] = image
        }
        if let visibility = visibility {
            dict[EventKeys.visibility] = visibility
        }
        if let description = description {
            dict[EventKeys.description] = description
        }
        if let totalCost = totalCost {
            dict[EventKeys.totalCost] = totalCost
        }
        
        // references
        if let tag = tag {
            dict[EventKeys.tag] = tag.id
        }
        if let participants = participants {
            dict[EventKeys.participants] = participants.map { $0.id }
        }
        if let owner = owner {
            dict[EventKeys.owner] = owner.id
        }
        
        return dict
    }
    static func == (lhs: Event, rhs: Event) -> Bool {
          return lhs.id == rhs.id
      }
    
}



