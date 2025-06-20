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
            print("Email and password are required.")
            return
        }
        do {
            let authUserResponse = try await authRepository.signUp(
                .init(email: email, password: password)
            )
            print("User signed up successfully: \(email)")
            
            // create user in database
            let newUser: User = .init(
                id: authUserResponse.uid,
                name: user.name,
                email: email,
                photo: user.photo ?? nil,
                domain: UserDomain.email.rawValue
            )
            
            try await saveUser(user: newUser)
            
            
        } catch {
            print("Error signing up user: \(error.localizedDescription)")
            throw error
        }
    }
    func fetchUsers() async {
        do {
            self.users = try await userRepository.retrieveAll()
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
}
