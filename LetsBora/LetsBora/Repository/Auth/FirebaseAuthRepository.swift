//
//  FirebaseAuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import Foundation
import FirebaseAuth

actor FirebaseAuthRepository: AuthRepository {
    let authInstance: Auth
    
    init(auth: Auth = FirebaseFactory.makeAuth()) {
        self.authInstance = auth
    }
    
    func signIn(_ auth: AuthUser) async throws -> String {
        guard let email = auth.email,
              let password = auth.password
        else {
            throw AuthRepositoryError.signInFailed
        }
        
        do {
            let response = try await authInstance
                .signIn(
                    withEmail: email,
                    password: password
                )
            
            return response.user.uid
        } catch {
            let authError = FirebaseError<FirebaseAuthErrorCode>(from: error)
            
            switch authError.code {
            case FirebaseAuthErrorCode.userNotFound:
                throw AuthRepositoryError.signInUserNotFound
            case FirebaseAuthErrorCode.invalidPassword:
                throw AuthRepositoryError.signInWrongPassword
            case FirebaseAuthErrorCode.incorrectCredentials:
                throw AuthRepositoryError.signInFailed
            default:
                throw AuthRepositoryError.signInFailed
            }
        }
    }
    
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse {
        guard let email = auth.email,
              let password = auth.password
        else {
            throw AuthRepositoryError.signUpFailed
        }
        
        var resut: AuthUserResponse
        do {
            let response = try await authInstance
                .createUser(
                    withEmail: email,
                    password: password
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
    
    func logout() async throws {
        do {
             try authInstance.signOut()
        } catch {
            print("error in logout \(error)")
            throw AuthRepositoryError.logoutFailed
        }
            
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await authInstance.sendPasswordReset(
                withEmail: email
            )
        } catch {
            print("error in resetPassword \(error)")
            throw AuthRepositoryError.resetPasswordFail
        }
    }
    
}
