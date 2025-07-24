//
//  FirestoreNotificationRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 24/07/25.
//

import FirebaseFirestore

actor FirestoreNotificationRepository: @preconcurrency NotificationRepository {
    let collection: CollectionReference
    
    init(
        firestore: Firestore = FirebaseFactory.makeFirestore()
    ){
        self.collection = firestore.collection(NotificationKeys.collectionName)
    }
    
    
    func create(_ notification: Notification) async throws {
        do {
            let data = try notification.toDictionary()
            try await collection
                .document(notification.id)
                .setData(data)
        } catch {
            throw NotificationError.creationFailed
        }
    }
    
    func retrieve(for id: String) async throws -> Notification? {
        do {
            let snapshot = try await collection
                .document(id)
                .getDocument()
            
            let notification = try snapshot.decoded(as: Notification.self)
            return notification
            
        } catch {
            throw NotificationError.retrievalFailed
        }
    }
    
    func retrieveAll() async throws -> [Notification] {
        var notifications: [Notification] = []
        
        do {
            let snapshotQuery = try await collection.getDocuments()
            
            for snapshot in snapshotQuery.documents {
               
                do {
                    let notification = try snapshot.decoded(as: Notification.self)
                    notifications.append(notification)
                } catch {
                    print("Failed to decode snapshot notification")
                    continue
                }
            }
        } catch {
            throw NotificationError.retrievalFailed
        }
        return notifications
    }
    
    func update(_ notification: Notification) async throws {
        do {
            try await collection
                .document(notification.id)
                .updateData(notification.toDictionary())
        } catch {
            throw NotificationError.updateFailed
        }
    }
    
    func delete(for id: String) async throws {
        do {
            try await collection.document(id).delete()
        } catch {
            throw NotificationError.deletionFailed
        }
    }
}
