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
    
    private func registerToFirestore (
        user: User
    ) async throws -> Void {
        do {
            try await userRepository.create(user)
        } catch {
            throw error
        }
    }
    
    
    @MainActor
    func signInGoogle() async throws -> Void
    {
        // Create Google Sign In configuration object.
        guard let gidSignIn = FirebaseFactory
            .makeGoogleSignIn() else {
            print("error creating Google Sign In configuration object")
            return
        }
        
        
        let result = try await gidSignIn.signIn(
            withPresenting: self.viewController
        )
        
        print("result of Google Sign In: \(result)")
        
        guard let idToken = result.user.idToken?.tokenString else {
            print("Google ID Token is nil")
            return }
        
        guard let profile = result.user.profile else {
            print("Failed to load profile")
            return
        }
        
        print("Load profile with success \(profile)")
        let name = profile.name
        let email = profile.email
        
        
        let accessToken = result.user.accessToken.tokenString
        
        let signInUser = AuthUser(
            googleIDToken: idToken,
            googleAccessToken: accessToken
        )
        
        self.authRepository = GoogleAuthRepository()
        
        do {
            let userId = try await authRepository.signIn(signInUser)
            
            // create user in db
            let userToCreate = User(
                id: userId,
                name: name,
                email: email,
            )
            
            do {
                let userLoggedIn = try await getUser(
                    id: userId
                )
                print("user already exists, just login")
                Utils.saveLoggedInUser(userLoggedIn)
            } catch  {
                print("user not found, create new user")
                try await registerToFirestore(
                    user: userToCreate
                )
                Utils.saveLoggedInUser(userToCreate)
            }
            
        } catch {
        print("Fail to Sign In with Google")
            throw error
        }
        
    }
    
}
