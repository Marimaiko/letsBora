//
//  ChatRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/07/25.
//

enum ChatRepositoryError: Error {
    case createChatFailed
    case retrieveFailed
    case retrieveAllFailed
    case updateFailed
    case deleteFailed
}
struct ChatQuery {
    let key: String
    let value: Any
}
protocol ChatRepository {
    func create(_ chat: Chat) async throws -> Void
    func retrieve(for id: String) async throws -> Chat
    func retrieveAll() async throws -> [Chat]
    func update(_ chat: Chat) async throws -> Void
    func delete(for id: String) async throws -> Void
    func retrieveEqual(_ query: ChatQuery) async throws -> [Chat]
}
