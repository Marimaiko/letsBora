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

        do {
            let eventDTO = try snapshot.data(as: EventDTO.self)
            let event = try await eventDTO.toEvent()
            return event
        } catch {
            print("Failed to parse event or resolve references from document: \(id). Error: \(error)")
            throw EventRepositoryError.retrieveFailed
        }
    }
    func retrieveAll() async throws -> [Event] {
        var events: [Event] = []
        do {
            let querySnapshot = try await collection.getDocuments()
            for doc in querySnapshot.documents {
                do {
                    let eventDTO = try doc.data(as: EventDTO.self)
                    print("event DTO: \(eventDTO)")
                    let event = try await eventDTO.toEvent()
                    events.append(event)
                } catch {
                    print("Failed to parse event from document: \(doc.documentID)")
                    continue
                }
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
                do {
                    let eventDTO = try doc.data(as: EventDTO.self)
                    let event = try await eventDTO.toEvent()
                    events.append(event)
                } catch {
                    print("Failed to parse event from document: \(doc.documentID)")
                    continue
                }
            }
        } catch {
            throw EventRepositoryError.eventNotFound
        }
        return events
    }
}
