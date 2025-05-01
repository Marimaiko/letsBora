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
        type: .notification,
        text: "João confirmou presença no evento"
    )
    
    static let chat3: Chat = .init(
        type: .message,
        text: "Pessoal, vamos fazer uma votação para o cardápio?",
        user: user1,
        activeOwner: false,
        date: "10:30",
        seen: true
    )
    static let chat4: Chat = .init(
        type: .message,
        text: "👀",
        user: user2,
        activeOwner: false,
        date: "10:31",
        seen: true
    )
    static let chat5: Chat = .init(
        type: .message,
        text: "Boa idéia, vou criar a enquete! \nNão esqueçam de responder.",
        user: user3,
        activeOwner: true,
        date: "10:37",
        seen: false
    )
    static let chat6: Chat = .init(
        type: .notification,
        text: "Judas criou uma enquete"
    )
    static let chat7: Chat = .init(
        type: .survey,
        text: "Qual o melhor Cardápio para o evento?",
        desciption: "Vote na sua opção favorita de comida! ",
        date:"10:40",
        survey: [
            .init(title: "Churrasco de Frango", votes: "8 votos"),
            .init(title: "Caldo de Galinha", votes: "7 votos"),
        ]
    )
}
