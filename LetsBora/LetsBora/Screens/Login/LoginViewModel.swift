//
//  LoginViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

class LoginViewModel {
    private var authRepository: AuthRepository
    private let userRepository: UserRepository
    private let viewController: LoginViewController
    init(
        authRepository: AuthRepository = FirebaseAuthRepository(),
        userRepository: UserRepository = FirestoreUserRepository(),
        loginViewController: LoginViewController
    ){
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.viewController = loginViewController
    }
    
    
    private func getUser(id: String) async throws -> User {
        return try await userRepository.retrieve(for: id)
    }
    
    func login(email: String, password: String) async throws -> Void {
        self.authRepository = FirebaseAuthRepository()
        
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
    func signInGoogle() async throws -> Void
    {

        // Create Google Sign In configuration object.
        guard let gidSignIn = FirebaseFactory.makeGoogleSignIn() else { return }

        
        let result = try await gidSignIn.signIn(
            withPresenting: self.viewController
        )
        
        guard let idToken = result.user.idToken?.tokenString else { return }
        
        let accessToken = result.user.accessToken.tokenString
        
        let signInUser = AuthUser(
            googleIDToken: idToken,
            googleAccessToken: accessToken
        )
        
        self.authRepository = GoogleAuthRepository()
        
        do {
            let userId = try await authRepository.signIn(signInUser)
            
            // retrieve user infos in firestore
            let userLoggedIn = try await getUser(id: userId)
            
            // save as useDefault
            Utils.saveLoggedInUser(userLoggedIn)
            
        } catch {
            throw error
        }
        
        
        
        
    }
    
}
