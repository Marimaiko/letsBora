//
//  RegisterViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 22/05/25.
//

class RegisterViewModel {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = InMemoryUserRepository()) {
        self.userRepository = userRepository
    }
}
