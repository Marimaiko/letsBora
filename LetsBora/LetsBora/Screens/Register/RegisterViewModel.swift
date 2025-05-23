//
//  RegisterViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

class RegisterViewModel {
    private let userRepository: UserRepository
    private(set) var users: [User] = []
    
    init(userRepository: UserRepository = InMemoryUserRepository()) {
        self.userRepository = userRepository
    }
    
    func saveUser(user: User) async {
        do {
            try await userRepository.create(user)
            print("User saved successfully: \(user)")
        } catch {
            print("Error saving user: \(error.localizedDescription)")
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
