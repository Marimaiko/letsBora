//
//  AuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import Foundation
import FirebaseAuth

enum AuthRepositoryError: Error, LocalizedError {
    case signUpFailed
    case signInFailed
    case signInUserNotFound
    case signInWrongPassword
    case logoutFailed
    case resetPasswordFail
    
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
        case .logoutFailed:
            return "Não foi possível fazer logout. Tente novamente."
        case .resetPasswordFail:
            return "Não foi possível resetar a senha. Tente novamente mais tarde."
        }
    }
}

protocol AuthRepository {
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse
    func signIn(_ auth: AuthUser) async throws -> String
    
    func logout() async throws
    
    func resetPassword(email: String) async throws
}
