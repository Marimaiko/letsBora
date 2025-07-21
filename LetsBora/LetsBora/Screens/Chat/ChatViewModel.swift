//
//  ChatViewModel.swift
//  LetsBora
//
//  Created by Davi Paiva on 02/07/25.
//
import Foundation
protocol ChatViewModelProtocol: AnyObject {
    func reloadTable() -> Void
}
class ChatViewModel {
    private(set) var chatGroup: ChatGroup
    var chatRepository: ChatRepository
    
    var owner: User? {
        return Utils.getLoggedInUser()
    }
    
    private weak var delegate: ChatViewModelProtocol?
    
    func delegate(with delegate: ChatViewModelProtocol) {
        self.delegate = delegate
    }
    
    init(_ chat: ChatGroup){
        chatGroup = chat
        chatRepository = FirestoreChatRepository()
    }
    
    func listenForNewMessages() {
        chatRepository.listenChat(for: chatGroup.id) { [weak self] result in
            switch result {
            case .success(let chatGroup):
                print("Received chat update ...")
                self?.chatGroup = chatGroup
                self?.delegate?.reloadTable()

            case .failure(let error):
                print("Failed to listen for chat updates:", error)
            }
        }
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
            delegate?.reloadTable()
            return true
        } catch {
            print(
                "Failed to update chat group: \(error.localizedDescription)"
            )
            return false
        }
    }
}
