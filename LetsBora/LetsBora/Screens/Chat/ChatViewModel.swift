//
//  ChatViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 02/07/25.
//
import Foundation
class ChatViewModel {
    private(set) var chatGroup: ChatGroup
    var chatRepository: ChatRepository
    
    var owner: User? {
        return Utils.getLoggedInUser()
    }
    
    init(_ chat: ChatGroup){
        chatGroup = chat
        chatRepository = FirestoreChatRepository()
    }
    
    func sendMessage(_ text: String) async -> Bool{
        let newMessage = Chat(
            type:.message,
            text: text,
            user: owner,
            date: Date().toString(),
        )
        chatGroup.messages.append(newMessage)
        return await updateChatGroup()
    }
    func updateChatGroup() async -> Bool {
        do {
            try await chatRepository.update(chatGroup)
            return true
        } catch {
            print(
                "Failed to update chat group: \(error.localizedDescription)"
            )
            return false
        }
    }
}
