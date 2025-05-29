//
//  AuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//

enum AuthRepositoryError: Error {
    case signUpFailed
    case signInFailed
    case userNotFound
}

protocol AuthRepository {
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse
    func signIn(_ auth: AuthUser) async throws -> Void
}
