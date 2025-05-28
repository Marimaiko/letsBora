//
//  FirebaseUserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import FirebaseFirestore

actor FirestoreUserRepository : UserRepository {
    let collection = Firestore.firestore().collection("users")
    
    func create(
        _ user: User
    ) async throws -> Void {
        // TODO: Refactor this user create dir
        let id = user.id
        
        var dataDict = [
            "userId" : id,
            "name": user.name,
            "createdAt": Date()
        ] as [String : Any]
        
        if let email = user.email {
            dataDict["email"] = email
        }
        if let photo = user.photo {
            dataDict["photo"] = photo
        }
        
        do {
            try await collection.document(id).setData(dataDict)
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
        // TODO: Refactor this get dict
        let userID = data["userId"] as! String
        let name = data["name"] as! String
        let email = data["email"] as? String ?? ""
        let photo = data["photo"] as? String ?? ""
        return User(id: userID, name: name, email: email, photo: photo)
    }
    
    func retrieveAll(
    ) async throws -> [User] {
        var users: [User] = []
        do {
            let querySnapshot = try await collection.getDocuments()
            for data in querySnapshot.documents {
                let userID = data["userId"] as! String
                let name = data["name"] as! String
                let email = data["email"] as? String ?? ""
                let photo = data["photo"] as? String ?? ""
                users.append(
                    User(
                        id: userID,
                        name: name,
                        email: email,
                        photo: photo
                    )
                )
            }
        } catch {
            throw UserRepositoryError.retrieveAllFailed
        }
        
        return users
    }
    
    func update(
        _ user: User
    ) async throws -> Void {
        var dataDict = [
            "userId" : user.id,
            "name": user.name,
        ] as [String : Any]
        
        if let email = user.email {
            dataDict["email"] = email
        }
        if let photo = user.photo {
            dataDict["photo"] = photo
        }
        
        let userRef  = collection.document(user.id)
        do {
            try await  userRef
                .updateData(dataDict)
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
