//
//  GoogleAuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

actor GoogleAuthRepository: AuthRepository {
    let authInstance: Auth
    
    init(auth: Auth = FirebaseFactory.makeAuth()) {
        self.authInstance = auth
    }
    
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse {
        return AuthUserResponse(uid: "123")
    }
    
    func signIn(_ auth: AuthUser) async throws -> String {
        guard let idToken = auth.googleIDToken,
              let accessToken = auth.googleAccessToken else {
            throw AuthRepositoryError.signInFailed
        }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        do {
            let response = try await authInstance.signIn(with: credential)
            return response.user.uid
        } catch {
            let _ = FirebaseError<FirebaseAuthErrorCode>(from: error)
            throw AuthRepositoryError.signInFailed
            
        }
    }
    func logout() async throws {
        
    }
}
