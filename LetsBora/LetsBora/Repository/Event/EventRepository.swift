//
//  EventRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 23/05/25.
//

enum EventRepositoryError: Error {
    case eventNotFound
    case emptyData
}
protocol EventRepository {
    func create(_ event: Event) async throws(EventRepositoryError) -> Void
    func retrieve(for id: String) async throws(EventRepositoryError) -> Event
    func retrieveAll() async throws(EventRepositoryError) -> [Event]
    func update(_ event: Event) async throws(EventRepositoryError) -> Void
    func delete(for id: String) async throws(EventRepositoryError) -> Void
}
