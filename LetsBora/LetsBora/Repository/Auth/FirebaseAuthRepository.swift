//
//  FirebaseAuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import Foundation
import FirebaseAuth

private let errorKey = "FIRAuthErrorUserInfoNameKey"


actor FirebaseAuthRepository: AuthRepository {
    let authInstance: Auth
    
    init(auth: Auth = FirebaseFactory.makeAuth()) {
        self.authInstance = auth
    }
    
    func signIn(_ auth: AuthUser) async throws -> String {
        do {
            let response = try await authInstance
                .signIn(
                    withEmail: auth.email,
                    password: auth.password
                )
            
            return response.user.uid
        } catch {
            let authError = FirebaseError<FirebaseAuthErrorCode>(from: error)
            
            switch authError.code {
            case FirebaseAuthErrorCode.userNotFound:
                throw AuthRepositoryError.signInUserNotFound
            case FirebaseAuthErrorCode.invalidPassword:
                throw AuthRepositoryError.signInWrongPassword
            default:
                throw AuthRepositoryError.signInFailed
            }
        }
    }
    
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
            print("error in signUp \(error)")
            throw AuthRepositoryError.signUpFailed
        }
        return resut
    }
    
    
}
