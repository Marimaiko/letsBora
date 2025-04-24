//
//  EventMocks.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//
import Foundation
import UIKit

struct MockData {
    static let tag1: Tag = .init(title: "Show", color: .black, bgColor: .systemYellow)
    static let tag2: Tag = .init(title: "Jogos", color: .black, bgColor: .green)
    static let tag3: Tag = .init(title: "Concerto", color: .black, bgColor: .systemBlue)
    static let tag4: Tag = .init(title: "Filmes", color: .black, bgColor: .systemRed)
    static let tag5: Tag = .init(title: "Workshops", color: .black, bgColor: .systemGray)
    static let tag6: Tag = .init(title: "Esportes", color: .black, bgColor: .systemOrange)
    
    
    static let eventMock1: Event = .init(
        title: "Festival de Verão 2025",
        image: "imageCard1",
        tag: .init(title: "Show", color: .black, bgColor: .systemYellow),
        visibility: "Public",
        date: "25 Mar",
        location: "Arena Show - São Paulo, SP",
        participants: [
            .init(name: "John"),
            .init(name: "Julia"),
            .init(name: "James"),
            .init(name: "Paul")
        ],
        owner: .init(name: "Joao")
    )
    
    static let eventMock2: Event = .init(
        title: "Show dos Casca de Bala",
        image: "imageCard2",
        tag: .init(title: "Show", color: .black, bgColor: .systemYellow),
        visibility: "Public",
        date: "30 Ago",
        location: "Kukukaya - Uberlândia, MG",
        participants: [
            .init(name: "Carlos"),
            .init(name: "Lúcia")
        ],
        owner: .init(name: "Pedro")
    )
    
    static let eventMock3: Event = .init(
        title: "Vôlei de Praia",
        image: "imageCard3",
        tag: .init(title: "Jogos", color: .black, bgColor: .green),
        visibility: "Public",
        date: "30 Abr",
        location: "Praia do Futuro - Fortaleza, CE",
        participants: [
            .init(name: "Ana"),
            .init(name: "Bruno"),
            .init(name: "Carla"),
            .init(name: "Sophia"),
            .init(name: "Diego"),
            .init(name: "Lara"),
            .init(name: "Mateus"),
            .init(name: "Isabela"),
            .init(name: "Thiago"),
            .init(name: "Camila"),
            .init(name: "Rafael")
        ],
        owner: .init(name: "Fernanda")
    )
    
    static let events: [Event] = [
        eventMock1,
        eventMock2,
        eventMock3
    ]
    static let tags: [Tag]  =  [
        tag1,
        tag2,
        tag3,
        tag4,
        tag5,
        tag6
        
        
    ]
}
