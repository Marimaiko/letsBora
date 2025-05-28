//
//  FirebaseAuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import Foundation
import FirebaseAuth

actor FirebaseAuthRepository: AuthRepository {
    let authInstance =  Auth.auth()
    
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse {
        var resut: AuthUserResponse
        do {
            let response = try await authInstance
                .createUser(
                    withEmail: auth.email,
                    password: auth.password
                )
            resut = AuthUserResponse(
                uid: response.user.uid
            )
        } catch {
            throw AuthRepositoryError.signUpFailed
        }
        return resut
    }
    
    
}
