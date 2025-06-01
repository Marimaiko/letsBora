//
//  InMemoryUserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

import Foundation

actor InMemoryUserRepository: UserRepository {
    
    func create(_ user: User) async throws -> Void {
        MockData.users.append(user)
    }
    func retrieve(for id: String) async throws -> User {
        let user = MockData.users.first(where: { $0.id == id })
        guard let user else {
            throw UserRepositoryError.userNotFound
        }
        return user
    }
    
    func retrieveAll() async throws -> [User] {
        guard !MockData.users.isEmpty else {
            throw UserRepositoryError.emptyData
        }
        return MockData.users
    }
    func update(_ user: User) async throws -> Void {
        let id = user.id

        guard let index = MockData.users.firstIndex(where: {$0.id == id}) else {
            throw UserRepositoryError.userNotFound
        }
        
        MockData.users[index] = user
    }
    
    func delete(for id: String) async throws -> Void {
        guard let index = MockData.users.firstIndex(where: {$0.id == id}) else {
            throw UserRepositoryError.userNotFound
        }
        MockData.users.remove(at: index)
    }
    
    func retrieveEqual(_ query: UserQuery) async throws -> [User] {
        throw UserRepositoryError.retrieveFailed
    }
    
}
