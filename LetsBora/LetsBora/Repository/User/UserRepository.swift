//
//  UserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

enum UserRepositoryError: Error {
    case userNotFound
    case emptyData
}

protocol UserRepository {
    func create(_ user: User) async throws -> Void
    func retrieve(for id: String) async throws -> User
    func retrieveAll() async throws -> [User]
    func update(_ user: User) async throws -> Void
    func delete(for id: String) async throws -> Void
}
