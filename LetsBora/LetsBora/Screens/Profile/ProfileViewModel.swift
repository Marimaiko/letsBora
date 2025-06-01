//
//  ProfileViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/05/25.
//

class ProfileViewModel {
    private var authRepository: AuthRepository
    
    init(
        authRepository: AuthRepository =
        FirebaseAuthRepository()
    ) {
        self.authRepository = authRepository
    }
    
    
    
    func logout() async throws {
        do {
            try await authRepository.logout()
            Utils.removeLoggedInUser()
        } catch {
            throw error
        }
        
    }
    
    
}
