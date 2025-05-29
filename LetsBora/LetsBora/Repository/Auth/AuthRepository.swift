//
//  AuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import Foundation

enum AuthRepositoryError: Error, LocalizedError {
    case signUpFailed
    case signInFailed
    case signInUserNotFound
    case signInWrongPassword

    var errorDescription: String? {
        switch self {
        case .signUpFailed:
            return "Não foi possível criar a conta. Tente novamente mais tarde."
        case .signInFailed:
            return "Não foi possível fazer login. Verifique suas credenciais."
        case .signInUserNotFound:
            return "Usuário não encontrado. Verifique o e-mail informado."
        case .signInWrongPassword:
            return "Senha incorreta. Tente novamente."
        }
    }
}

protocol AuthRepository {
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse
    func signIn(_ auth: AuthUser) async throws -> Void
}
