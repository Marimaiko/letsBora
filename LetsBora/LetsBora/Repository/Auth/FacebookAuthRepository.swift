//
//  FacebookAuthRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/05/25.
//
import FirebaseAuth

actor Facebook: AuthRepository {
    let authInstance: Auth
    
    init(authInstance: Auth = FirebaseFactory.makeAuth()) {
        self.authInstance = authInstance
    }
    
    func signUp(_ auth: AuthUser) async throws -> AuthUserResponse {
        return AuthUserResponse(uid: "123")
    }
    
    func signIn(_ auth: AuthUser) async throws -> String {
        return "123"
    }
    func logout() async throws {
         
    }
    
}
