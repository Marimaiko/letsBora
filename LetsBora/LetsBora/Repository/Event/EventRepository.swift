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
    func create(_ event: Event) async throws -> Void
    func retrieve(for id: String) async throws -> Event
    func retrieveAll() async throws -> [Event]
    func update(_ event: Event) async throws -> Void
    func delete(for id: String) async throws -> Void
}
