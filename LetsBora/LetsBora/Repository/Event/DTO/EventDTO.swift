//
//  EventDTO.swift
//  LetsBora
//
//  Created by Davi Paiva on 10/06/25.
//

import FirebaseFirestore

struct EventDTO: Identifiable, Codable {
    var id: String
    var title: String
    var image: String?
    var tag: String? // tagId
    var visibility: String?
    var date: String
    var locationDetails: EventLocationDetails?
    var description: String?
    var totalCost: String?
    var participants: [String]? // participants IDs
    var owner: String? // ownerId

  
    func toEvent() async throws -> Event {
        var event = toLightEvent()

        if let tagId = tag {
            event.tag = try await FirestoreTagRepository().retrieve(for: tagId)
        }

        if let ownerId = owner {
            event.owner = try await FirestoreUserRepository().retrieve(for: ownerId)
        }

        if let participantIds = participants {
            event.participants = try await withThrowingTaskGroup(of: User.self) { group in
                for id in participantIds {
                    group.addTask {
                        return try await FirestoreUserRepository().retrieve(for: id)
                    }
                }

                var loadedUsers: [User] = []
                for try await user in group {
                    loadedUsers.append(user)
                }
                return loadedUsers
            }
        }

        return event
    }

    
    func toLightEvent() -> Event {
        return Event(
            id: id,
            title: title,
            image: image,
            tag: nil, // não carregado
            visibility: visibility,
            date: date,
            locationDetails: locationDetails,
            description: description,
            totalCost: totalCost,
            participants: nil, // não carregado
            owner: nil // não carregado
        )
    }
}
