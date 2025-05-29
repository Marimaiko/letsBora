//
//  LoginViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//

class LoginViewModel {
    private let authRepository: AuthRepository
    
    init(
        authRepository: AuthRepository = FirebaseAuthRepository()
    ){
        self.authRepository = authRepository
    }
    
    func login(email: String, password: String) async -> Bool {
        let auth = AuthUser(email: email, password: password)
        do  {
            try await authRepository.signIn(auth)
            return true
        } catch{
            return false
        }
    }
    
    
}
