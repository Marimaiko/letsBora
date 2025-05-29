//
//  LoginViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//

class LoginViewModel {
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    
    init(
        authRepository: AuthRepository = FirebaseAuthRepository(),
        userRepository: UserRepository = FirestoreUserRepository()
    ){
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    
    private func getUser(id: String) async throws -> User {
        return try await userRepository.retrieve(for: id)
    }
    
    func login(email: String, password: String) async throws -> Void {
        let auth = AuthUser(email: email, password: password)
        do {
            // sign in
            let userId = try await authRepository.signIn(auth)
            
            // retrieve user infos in firestore
            let userLoggedIn = try await getUser(id: userId)
            
            // save as useDefault
            Utils.saveLoggedInUser(userLoggedIn)
        }
        catch {
            throw error
        }
    }
    
    
}
