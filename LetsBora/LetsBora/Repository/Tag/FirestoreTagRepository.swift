//
//  FirestoreTagRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//

import FirebaseFirestore

actor FirestoreTagRepository : TagRepository {
    let collection: CollectionReference
    
    init(
        firestore: Firestore =  FirebaseFactory.makeFirestore()
    ){
        self.collection = firestore.collection(TagKeys.collectionName)
    }
    
    func retrieve(for id: String) async throws -> Tag {
        let snapshot = try await collection.document(id).getDocument()
        guard let data = snapshot.data() else {
            throw TagRepositoryError.tagNotFound
        }
        guard let tag = Tag(from: data) else {
            throw TagRepositoryError.retrieveFailed
        }
        return tag
    }
    
    func retrieveAll() async throws -> [Tag] {
        var tags: [Tag] = []
        
        do {
            let querySnapshot = try await collection.getDocuments()
            for doc in  querySnapshot.documents {
                guard let tag = Tag(from:doc.data()) else {
                    print("Failed to parse tag document \(doc.documentID)")
                    continue
                }
                tags.append(tag)
            }
        } catch {
            throw TagRepositoryError.retrieveAllFailed
        }
        return tags
    }
    
}
