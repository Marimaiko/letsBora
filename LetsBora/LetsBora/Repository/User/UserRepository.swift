//
//  UserRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//
import Foundation

enum UserRepositoryError: Error, LocalizedError {
    case userNotFound
    case emptyData
    case createUserFailed
    case updateUserFailed
    case retrieveAllFailed
    case deleteUserFailed
    case retrieveFailed
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "Usuário não encontrado"
        case .emptyData:
            return "Nenhum dado encontrado"
        case .createUserFailed:
            return "Erro ao criar usuário"
        case .updateUserFailed:
            return "Erro ao atualizar usuário"
        case .retrieveAllFailed:
            return "Erro ao recuperar todos os usuários"
        case .deleteUserFailed:
            return "Erro ao deletar usuário"
        case .retrieveFailed:
            return "Erro ao recuperar usuário"
        
        }
    }
    
}

struct UserQuery {
    var key: String
    var value: Any
    
}
protocol UserRepository {
    func create(_ user: User) async throws -> Void
    func retrieve(for id: String) async throws -> User
    func retrieveAll() async throws -> [User]
    func update(_ user: User) async throws -> Void
    func delete(for id: String) async throws -> Void
    
    func retrieveEqual(_ query: UserQuery) async throws -> [User]
}
