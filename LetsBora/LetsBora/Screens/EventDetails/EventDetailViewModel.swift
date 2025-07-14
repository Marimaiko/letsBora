//
//  EventDetailViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 02/07/25.
//
import Foundation
class EventDetailViewModel {
    var event: Event
    var chat: ChatGroup?
    var chatRepository: ChatRepository
    var eventRespository: EventRepository
    init(event: Event) {
        self.chatRepository = FirestoreChatRepository()
        self.eventRespository = FirestoreEventRepository()
        self.event = event
    }
    
    func updateEvent(_ event: Event) {
        self.event = event
    }
    func openChat() async {
        if event.chatId != nil {
            do {
                try await getChat()
                print("Chat retrieved")
            } catch {
                print(error.localizedDescription)
            }
        } else {
            do {
                try await createNewChat()
                try await eventRespository.update(event)
                print("Chat created")
            } catch {
                if event.chatId != nil {
                    await deleteChat()
                }
                print(error.localizedDescription)
            }
        }
    }
    func createNewChat() async throws -> Void {
        self.chat = ChatGroup()
        guard let chat = self.chat else {
            print("Invalid Chat")
            throw NSError(
                domain: "Invalid Chat",
                code: 1001,
                userInfo: nil
            )
        }
        
        do {
            try await chatRepository.create(chat)
            event.chatId = chat.id
        } catch {
            event.chatId = nil
            throw error
        }
    }
    func deleteChat() async -> Void {
        guard let id = event.chatId else {
            return
        }
        do {
            try await chatRepository.delete(for: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getChat() async throws -> Void {
        guard let id = event.chatId else {
            throw NSError(
                domain: "Invalid Chat",
                code: 1001,
                userInfo: nil
            )
        }
        self.chat = try await chatRepository.retrieve(for: id)
    }
    
}
