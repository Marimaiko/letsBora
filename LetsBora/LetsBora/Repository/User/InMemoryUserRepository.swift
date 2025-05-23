//
//  InMemoryUserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

import Foundation

actor InMemoryUserRepository: UserRepository {
    
    func create(_ user: User) async throws(UserRepositoryError) -> Void {
        MockData.users.append(user)
    }
    func retrieve(for id: String) async throws(UserRepositoryError) -> User {
        let user = MockData.users.first(where: { $0.id == id })
        guard let user else {
            throw .userNotFound
        }
        return user
    }
    
    func retrieveAll() async throws(UserRepositoryError) -> [User] {
        guard !MockData.users.isEmpty else {
            throw .emptyData
        }
        return MockData.users
    }
    func update(_ user: User) async throws(UserRepositoryError) -> Void {
        let id = user.id

        guard let index = MockData.users.firstIndex(where: {$0.id == id}) else {
            throw .userNotFound
        }
        
        MockData.users[index] = user
    }
    
    func delete(for id: String) async throws(UserRepositoryError) -> Void {
        guard let index = MockData.users.firstIndex(where: {$0.id == id}) else {
            throw .userNotFound
        }
        MockData.users.remove(at: index)
    }
}
