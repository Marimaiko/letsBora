//
//  RegisterViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

import Foundation

class RegisterViewModel {
    private let userRepository: UserRepository
    private let authRepository: AuthRepository
    
    private(set) var users: [User] = []
    
    init(
        userRepository: UserRepository = FirestoreUserRepository(),
        authRepository: AuthRepository = FirebaseAuthRepository()
    ) {
        self.userRepository = userRepository
        self.authRepository = authRepository
    }
    
    private func saveUser(user: User) async throws -> Void {
        do {
            try await userRepository.create(user)
            print("User saved successfully: \(user.name)")
        } catch {
            print("Error saving user in viewModel: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signUp(user: User) async throws {
        guard let email = user.email,
              let password = user.password else {
            print("Email and password are required for signUp in ViewModel.")
            
            throw NSError(domain: "RegisterViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Email e senha são obrigatórios."])
        }
        
        let authUserResponse = try await authRepository.signUp(
            .init(email: email, password: password)
        )
        print("User authenticated successfully via Auth: \(email)")
        
        let newUser: User = .init(
            id: authUserResponse.uid, // ID da autenticação
            name: user.name,          // Nome vindo da UI
            email: email,             // Email vindo da UI
            photo: user.photo         // Foto (se houver) vinda da UI
        )
        
        try await saveUser(user: newUser)
    }
    
    func fetchUsers() async {
        do {
            self.users = try await userRepository.retrieveAll()
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
}
