//
//  FirestoreEventRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 02/06/25.
//


import FirebaseFirestore

actor FirestoreEventRepository: EventRepository {
    let collection: CollectionReference

    init(firestore: Firestore = FirebaseFactory.makeFirestore()) {
        self.collection = firestore.collection(EventKeys.collectionName)
    }

    func create(_ event: Event) async throws {
        do {
            try await collection
                .document(event.id)
                .setData(event.toDict)
        } catch {
            throw EventRepositoryError.createEventFailed
        }
    }

    func retrieve(for id: String) async throws -> Event {
        let snapshot = try await collection.document(id).getDocument()

        guard let data = snapshot.data() else {
            throw EventRepositoryError.eventNotFound
        }

        guard let event = Event(from: data) else {
            throw EventRepositoryError.retrieveFailed
        }

        return event
    }

    func retrieveAll() async throws -> [Event] {
        var events: [Event] = []
        do {
            let querySnapshot = try await collection.getDocuments()
            for doc in querySnapshot.documents {
                guard let event = Event(from: doc.data()) else {
                    print("Failed to parse event from document: \(doc.documentID)")
                    continue
                }
                events.append(event)
            }
        } catch {
            throw EventRepositoryError.retrieveAllFailed
        }
        return events
    }

    func update(_ event: Event) async throws {
        do {
            try await collection
                .document(event.id)
                .updateData(event.toDict)
        } catch {
            throw EventRepositoryError.updateEventFailed
        }
    }

    func delete(for id: String) async throws {
        do {
            try await collection.document(id).delete()
        } catch {
            throw EventRepositoryError.deleteEventFailed
        }
    }

    func retrieveEqual(_ query: EventQuery) async throws -> [Event] {
        var events: [Event] = []
        do {
            let querySnapshot = try await collection
                .whereField(query.key, isEqualTo: query.value)
                .getDocuments()
            for doc in querySnapshot.documents {
                guard let event = Event(from: doc.data()) else {
                    print("Failed to parse event from document: \(doc.documentID)")
                    continue
                }
                events.append(event)
            }
        } catch {
            throw EventRepositoryError.eventNotFound
        }
        return events
    }
}
