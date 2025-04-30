//
//  Chat+MockData.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

extension MockData{
    static let chat1: Chat = .init(
        type: .notification,
        text: "Hoje"
    )
    
    static let chat2: Chat = .init(
        type: .message,
        text: "João confirmou presença no evento"
    )
    
    static let chat3: Chat = .init(
        type: .message,
        text: "Judas criou uma enquete"
    )
    
}
