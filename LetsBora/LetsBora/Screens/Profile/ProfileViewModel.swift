//
//  ProfileViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/05/25.
//

class ProfileViewModel {
    private var authRepository: AuthRepository
    private var userRepository: UserRepository
    private var eventRepository: EventRepository
    
    typealias ProfileData = (user: User, eventCount: Int)
    
    init(
        authRepository: AuthRepository = FirebaseAuthRepository(),
        userRepository: UserRepository = FirestoreUserRepository(),
        eventRepository: EventRepository = FirestoreEventRepository()
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.eventRepository = eventRepository
    }
    
    /// Busca o perfil completo do usuário logado e a contagem de eventos que ele criou.
    func fetchUserProfileData() async throws -> ProfileData {
        // 1. Pega o ID do usuário logado
        guard let loggedInUser = Utils.getLoggedInUser() else {
            // Se não houver usuário logado, lança um erro para o Controller tratar
            throw UserRepositoryError.userNotFound
        }
        
        // 2. Busca os detalhes completos do usuário no Firestore
        // (Isso garante que temos os dados mais recentes, como nome e foto)
        let userProfile = try await userRepository.retrieve(for: loggedInUser.id)
        
        // 3. Busca os eventos criados por este usuário para contá-los
        let userEventsQuery = EventQuery(key: EventKeys.owner, value: userProfile.id)
        let userEvents = try await eventRepository.retrieveEqual(userEventsQuery)
        
        // 4. Retorna os dados combinados
        return (user: userProfile, eventCount: userEvents.count)
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
