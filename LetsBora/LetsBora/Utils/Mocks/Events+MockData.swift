// Events+MockData.swift

import Foundation
import CoreLocation

extension MockData {
    // Helper para criar datas para os mocks
     static func createMockDate(dayMonthString: String, year: Int = 2025) -> Date {
        let dateFormatter = DateFormatter()
        // O formato deve corresponder exatamente às suas strings "DD Mes"
        dateFormatter.dateFormat = "dd MMM yyyy"
        // É crucial definir o Locale para que os nomes dos meses sejam parseados corretamente.
        // Se suas strings de mês ("Mar", "Ago", "Abr") estão em português:
        dateFormatter.locale = Locale(identifier: "pt_BR")
        // Se estiverem em inglês ("Mar", "Aug", "Apr"):
        // dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: "\(dayMonthString) \(year)") {
            return date
        }
        // Fallback se o parsing falhar
        print("⚠️ Alerta: Não foi possível converter a string de data mock: '\(dayMonthString) \(year)'")
        return Date() // Retorna a data atual como fallback
    }

    static let eventMock1: Event = .init(
        title: "Festival de Verão 2025",
        image: "imageCard1",
        tag: tag1,
        visibility: "Public",
        date:  "25 Mar",
        locationDetails: EventLocationDetails(name: "Arena Show", address: "São Paulo, SP", latitude: -23.5505, longitude: -46.6333),
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
        tag: tag1,
        visibility: "Public",
        date: "30 Ago",
        locationDetails: EventLocationDetails(name: "Kukukaya", address: "Uberlândia, MG", latitude: -18.9186, longitude: -48.2772),
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
        tag: tag2,
        visibility: "Public",
        date: "30 Abr",
        locationDetails: EventLocationDetails(name: "Praia do Futuro", address: "Fortaleza, CE", latitude: -3.7319, longitude: -38.4901),
        description: "Vôlei de Praia",
        participants: [
            .init(name: "Ana"), .init(name: "Bruno"), .init(name: "Carla"), .init(name: "Sophia"),
            .init(name: "Diego"), .init(name: "Lara"), .init(name: "Mateus"), .init(name: "Isabela"),
            .init(name: "Thiago"), .init(name: "Camila"), .init(name: "Rafael")
        ],
        owner: .init(name: "Fernanda")
    )
    
    static let pastEvents: [Event] = [
        Event(
            title: "Vôlei de Praia",
            tag: tag2,
            visibility: "Public",
            date: "25 Mar",
            locationDetails: EventLocationDetails(name: "Praia do Futuro", address: "Fortaleza, CE", latitude: -3.7319, longitude: -38.4901),
            description: "Vôlei de Praia que já aconteceu",
            participants: [
                .init(name: "Ana"), .init(name: "Bruno")
            ],
            owner: .init(name: "Fernanda")
        ),
        
        Event(
            title: "Festival de Verão 2025",
            tag: tag1,
            visibility: "Public",
            date: "10 Jan",
            locationDetails: EventLocationDetails(name: "Arena Gelada", address: "Campos do Jordão, SP", latitude: -22.7395, longitude: -45.5910),
            description: "Festival de Inverno que já rolou",
            participants: [
                .init(name: "John"), .init(name: "Julia")
            ],
            owner: .init(name: "Joao")
        ),
        
        Event(
            title: "Show dos Casca de Bala",
            tag: tag1,
            visibility: "Public",
            date: "30 Ago",
            locationDetails: EventLocationDetails(name: "Arena Gelada", address: "Campos do Jordão, SP", latitude: -22.7395, longitude: -45.5910),
            description: "Show dos Casca de Bala",
            participants: [
                .init(name: "Carlos"),
                .init(name: "Lúcia")
            ],
            owner: .init(name: "Pedro")
        )
    ]
}
