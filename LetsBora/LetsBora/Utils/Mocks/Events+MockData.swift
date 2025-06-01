//
//  Events+Mock.swift
//  LetsBora
//
//  Created by Davi Paiva on 30/04/25.
//

extension MockData {
    static let eventMock1: Event = .init(
        title: "Festival de Verão 2025",
        image: "imageCard1",
        tag: .init(title: "Show",
                   color: .black,
                   bgColor: .systemYellow
                  ),
        visibility: "Public",
        date: "25 Mar",
        location: "Arena Show - São Paulo, SP",
        description: "Festival de Verão 2025",
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
        description: "Show dos Casca de Bala",
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
        description: "Vôlei de Praia",
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
    
    static let pastEvents: [Event] = [
        Event(
            title: "Vôlei de Praia",
            tag: .init(title: "Jogos", color: .black, bgColor: .green),
            visibility: "Public",
            date: "25 Mar",
            location: "Praia do Futuro - Fortaleza, CE",
            description: "Vôlei de Praia",
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
        ),
        
        Event(
            title: "Festival de Verão 2025",
            tag: .init(title: "Show", color: .black, bgColor: .systemYellow),
            visibility: "Public",
            date: "25 Mar",
            location: "Arena Show - São Paulo, SP",
            description: "Festival de Verão 2025",
            participants: [
                .init(name: "John"),
                .init(name: "Julia"),
                .init(name: "James"),
                .init(name: "Paul")
            ],
            owner: .init(name: "Joao")
        ),
        
        Event(
            title: "Show dos Casca de Bala",
            tag: .init(title: "Show", color: .black, bgColor: .systemYellow),
            visibility: "Public",
            date: "30 Ago",
            location: "Kukukaya - Uberlândia, MG",
            description: "Show dos Casca de Bala",
            participants: [
                .init(name: "Carlos"),
                .init(name: "Lúcia")
            ],
            owner: .init(name: "Pedro")
        )
    ]
    
}
