//
//  InMemoryUserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

import Foundation

actor InMemoryUserRepository: UserRepository {
    
    
    private var users: [User] = MockData.users
    
    func create(_ user: User) async throws(UserRepositoryError) -> Void {
        users.append(user)
    }
    func retrieve(for id: String) async throws(UserRepositoryError) -> User {
        let user = users.first(where: { $0.id == id })
        guard let user else {
            throw .userNotFound
        }
        return user
    }
    
    func retrieveAll() async throws(UserRepositoryError) -> [User] {
        guard !users.isEmpty else {
            throw .emptyData
        }
        return users
    }
    func update(_ user: User) async throws(UserRepositoryError) -> Void {
        let id = user.id

        guard let index = users.firstIndex(where: {$0.id == id}) else {
            throw .userNotFound
        }
        
        users[index] = user
    }
    
    func delete(for id: String) async throws(UserRepositoryError) -> Void {
        guard let index = users.firstIndex(where: {$0.id == id}) else {
            throw .userNotFound
        }
        users.remove(at: index)
    }
}
