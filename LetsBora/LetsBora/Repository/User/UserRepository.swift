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
    func create(_ user: User) async throws(UserRepositoryError) -> Void
    func retrieve(for id: String) async throws(UserRepositoryError) -> User
    func retrieveAll() async throws(UserRepositoryError) -> [User]
    func update(_ user: User) async throws(UserRepositoryError) -> Void
    func delete(for id: String) async throws(UserRepositoryError) -> Void
}
