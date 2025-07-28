//
//  ProfileEditViewModel.swift
//  LetsBora
//
//  Created by Joel Lacerda on 28/07/25.
//

import Foundation

enum ProfileUpdateError: Error, LocalizedError {
    case passwordMismatch
    case invalidEmail
    case weakPassword
    case updateFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .passwordMismatch:
            return "As senhas não correspondem."
        case .invalidEmail:
            return "O formato do e-mail é inválido."
        case .weakPassword:
            return "A nova senha deve ter pelo menos 6 caracteres."
        case .updateFailed(let message):
            return "Falha ao atualizar o perfil: \(message)"
        }
    }
}

class ProfileEditViewModel {
    
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    
    private var currentUser: User?
    
    public var originalEmail: String? {
        return currentUser?.email
    }
    
    init(
        authRepository: AuthRepository = FirebaseAuthRepository(),
        userRepository: UserRepository = FirestoreUserRepository()
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    /// Busca os dados do usuário logado para popular a tela.
    func fetchCurrentUser() async throws -> User {
        guard let loggedInUser = Utils.getLoggedInUser() else {
            throw UserRepositoryError.userNotFound
        }
        let user = try await userRepository.retrieve(for: loggedInUser.id)
        self.currentUser = user
        return user
    }
    
    /// Atualiza os dados do usuário no Firebase.
    func updateUser(name: String, email: String, newPassword: String?) async throws -> User {
        guard var userToUpdate = self.currentUser else {
            throw UserRepositoryError.userNotFound
        }
        
        // Atualiza o nome no objeto local
        userToUpdate.name = name
        
        // 1. Atualiza o nome no Firestore
        try await userRepository.update(userToUpdate)
        
        // 2. Atualiza o e-mail no Firebase Auth (se mudou)
        if email != userToUpdate.email {
            try await authRepository.updateEmail(to: email)
            userToUpdate.email = email // Atualiza o email no objeto local também
            try await userRepository.update(userToUpdate) // Salva o novo email no Firestore
        }
        
        // 3. Atualiza a senha no Firebase Auth (se uma nova foi fornecida)
        if let password = newPassword, !password.isEmpty {
            try await authRepository.updatePassword(to: password)
        }
        
        // Retorna o usuário com os dados atualizados
        return userToUpdate
    }
}
