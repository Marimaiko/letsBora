//
//  Event.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//

import Foundation

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

struct Event:Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var image: String?
    var tag: Tag?
    var visibility: String?
    var date: String
    var locationDetails: EventLocationDetails?
    var description: String?
    var totalCost: String?
    var participants: [User]?
    var owner: User?    //opcional por enquanto, até configurar a persistência de dados
    
    init(
        id: String = UUID().uuidString,
        title: String,
        image: String? = nil,
        tag: Tag? = nil,
        visibility: String? = nil,
        date: String,
        locationDetails: EventLocationDetails,
        description: String? = nil,
        totalCost: String? = nil,
        participants: [User]? = nil,
        owner: User? = nil
        
    ){
        self.title = title
        self.image = image
        self.tag = tag
        self.visibility = visibility
        self.date = date
        self.locationDetails = locationDetails
        self.description = description
        self.totalCost = totalCost
        self.participants = participants
        self.owner = owner
        
    }
    
    init?(
        from data: [String: Any]
    ) {
        // Required fields
        guard let id = data[EventKeys.id] as? String,
              let title = data[EventKeys.title] as? String,
              let date = data[EventKeys.date] as? String
        else {
            print("Failed to parse required Event fields")
            return nil
        }
        
        self.id = id
        self.title = title
        self.date = date
        
       
        
        // Optional fields
        if let image = data[EventKeys.image] as? String {
            self.image = image
        }
        
        if let visibility = data[EventKeys.visibility] as? String {
            self.visibility = visibility
        }
        
        if let description = data[EventKeys.description] as? String {
            self.description = description
        }
        
        if let totalCost = data[EventKeys.totalCost] as? String {
            self.totalCost = totalCost
        }
        
        if let locationData = data[EventKeys.locationDetails] as? [String: Any],
        let location = EventLocationDetails(from: locationData){
            self.locationDetails = location
        } else if data[EventKeys.locationDetails] != nil {
            print("Failed to parse location")
        }
        
        if let tagData = data[EventKeys.tag] as? [String: Any],
           let tag = Tag(from: tagData) {
            self.tag = tag
        } else if data[EventKeys.tag] != nil {
            print("Failed to parse tag")
        }
        
        if let ownerData = data[EventKeys.owner] as? [String: Any],
           let owner = User(from: ownerData) {
            self.owner = owner
        } else if data[EventKeys.owner] != nil {
            print("Failed to parse owner")
        }
        
        if let participantList = data[EventKeys.participants] as? [[String: Any]] {
            var loadedUsers: [User] = []
            for userData in participantList {
                if let user = User(from: userData) {
                    loadedUsers.append(user)
                } else {
                    print("Failed to parse participant")
                }
            }
            self.participants = loadedUsers
        }
    }
    var toDict: [
        String: Any
    ] {
        var dict: [String: Any] = [
            EventKeys.id: id,
            EventKeys.title: title,
            EventKeys.date: date,
            EventKeys.locationDetails: locationDetails?.toDict ?? ""
        ]
        
        if let image = image {
            dict[EventKeys.image] = image
        }
        if let tag = tag {
            dict[EventKeys.tag] = tag.toDict
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
        if let participants = participants {
            dict[EventKeys.participants] = participants.map { $0.toDict }
        }
        if let owner = owner {
            dict[EventKeys.owner] = owner.toDict
        }
        
        return dict
    }
    static func == (lhs: Event, rhs: Event) -> Bool {
          return lhs.id == rhs.id
      }
    
}



