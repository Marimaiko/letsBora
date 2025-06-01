//
//  ForgetPasswordViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 31/05/25.
//
import Foundation
class ForgetPasswordViewModel {
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    
    
    init(
        authRepository: AuthRepository = FirebaseAuthRepository(),
        userRepository: UserRepository = FirestoreUserRepository()
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    private func findUserByEmail(_ email: String) async throws -> Bool{
        var users:[User] = []

            users = try await userRepository
                .retrieveEqual(
                    .init(
                        key: UserKeys.email,
                        value: email
                    )
                )
            
        
        return users.count > 0
    }
    
    
    func resetPassword(email:String) async throws {
        
        var isFounded:Bool = false
        
        do {
             isFounded = try await findUserByEmail(email)
            print("isFounded: \(isFounded)")
        } catch {
            print("erro ao buscar o usuario: \(error)")
            throw error
        }
        if !isFounded {
            print("usuario não encontrado")
            throw UserRepositoryError.userNotFound
        }
        
        do {
            print("resetando a senha")
            try await authRepository.resetPassword(email: email)
        } catch {
            print("Falha ao resetar a senha: \(error)")
            throw error
        }
    }
    
}
