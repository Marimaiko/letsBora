//
//  FirebaseUserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import FirebaseFirestore

actor FirestoreUserRepository : UserRepository {
    let collection : CollectionReference
    
    init(
        firestore: Firestore = FirebaseFactory.makeFirestore()
    ){
        self.collection = firestore.collection(UserKeys.collectionName)
    }
    
    func create(
        _ user: User
    ) async throws -> Void {
        do {
            try await collection
                .document(user.id)
                .setData(user.toDict)
        } catch {
            throw UserRepositoryError.createUserFailed
        }
        
    }
    func retrieve(
        for id: String
    ) async throws -> User {
        
        let snapshot = try await collection
            .document(id)
            .getDocument()
        
        guard let data = snapshot.data() else {
            throw UserRepositoryError.userNotFound
        }
        guard let user = User(from: data) else {
            throw UserRepositoryError.retrieveFailed
        }
        return user
    }
    
    func retrieveAll(
    ) async throws -> [User] {
        var users: [User] = []
        do {
            let querySnapshot = try await collection.getDocuments()
            for doc in querySnapshot.documents {
                guard let user = User(from: doc.data()) else {
                    print("Failed to parse user from document: \(doc.documentID)")
                    continue
                }
                users.append(user)
            }
        } catch {
            throw UserRepositoryError.retrieveAllFailed
        }
        return users
    }
    
    func update(
        _ user: User
    ) async throws -> Void {
        
        do {
            try await collection.document(user.id)
                .updateData(user.toDict)
        } catch {
            throw UserRepositoryError.updateUserFailed
        }
        
        
    }
    func delete(
        for id: String
    ) async throws -> Void {
        do {
            try await collection.document(id).delete()
        } catch {
            throw UserRepositoryError.deleteUserFailed
        }
    }
}
