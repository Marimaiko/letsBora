//
//  FirestoreChatRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/07/25.
//

import FirebaseFirestore

actor FirestoreChatRepository: ChatRepository {
    let collection: CollectionReference
    
    init(firestore: Firestore = FirebaseFactory.makeFirestore()){
        self.collection = firestore.collection(ChatKeys.collectionName)
    }
    
    func create(_ chat: ChatGroup) async throws {
        do {
            let data = try chat.toDictionary()
            try await collection
                .document(chat.id)
                .setData(data)
        } catch {
            throw ChatRepositoryError.createChatFailed
        }
    }
    
    func retrieve(for id: String) async throws -> ChatGroup{
        do {
            let snapshot = try await collection
                .document(id)
                .getDocument()
            let chat = try snapshot
                .decoded(as:ChatGroup.self)
            return chat
        } catch {
            throw ChatRepositoryError.retrieveFailed
        }
    }
    
    func retrieveAll(
    ) async throws -> [ChatGroup] {
        var chats: [ChatGroup] = []
        do {
            let querySnapshot = try await collection
                .getDocuments()
            for doc in querySnapshot
                .documents {
                do {
                    let chat = try doc
                        .decoded(as: ChatGroup.self)
                    chats.append(chat)
                } catch {
                    print(
                        "Failed to decode chat in retrive: \(doc.documentID)"
                    )
                    continue
                }
            }
        } catch {
            throw ChatRepositoryError
                .retrieveFailed
        }
        return chats
    }
    
    func update(
        _ chat: ChatGroup
    ) async throws {
        do {
            try await collection
                .document(chat.id)
                .updateData(chat.toDictionary())
        } catch {
            throw ChatRepositoryError
                .updateFailed
        }
    }
    
    func delete(
        for id: String
    ) async throws {
        do {
            try await collection
                .document(id)
                .delete()
        } catch {
            throw ChatRepositoryError
                .deleteFailed
        }
    }
    
    func retrieveEqual(
        _ query: ChatQuery
    ) async throws -> [ChatGroup] {
        throw ChatRepositoryError.retrieveFailed
    }
    
    
    
    
}
