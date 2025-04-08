//
//  EventMocks.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//
import Foundation
//.setTitleLabel("Festival de Verão 2025")
//  .setLocationLabel("Arena Show - São Paulo, SP")
//.setDateLabel("25 Mar")
//.setTagViewTextColor(text: "Show",textColor: .black, backgroundColor: .systemYellow)
//.setAvatars(["","",""],12)
//  .setDetailButtonTitle("Participar")
let eventMock1: Event = .init(
    title: "Festival de Verão 2025",
    image: "imageCard1",
    category: .init(title: "Show", color: .black, bgColor: .systemYellow),
    visibility: "Public",
    date: "25 Mar",
    location: "Arena Show - São Paulo, SP",
    participants:[
        .init(name: "John"),
        .init(name: "Julia"),
        .init(name: "James"),
        .init(name: "Paul")
    ],
    owner: .init(name: "Joao"),
)
//  .setTitleLabel("Show dos Casca de Bala")
//  .setLocationLabel("Kukukaya - Uberlândia, MG")
//  .setDateLabel("30 Ago")
//  .setTagViewTextColor(text: "Show",textColor: .black,backgroundColor: .systemYellow)
//  .setAvatars(["",""])
// .setDetailButtonTitle("Participar")
//  .setImage("imageCard2")

// .setTitleLabel("Vôlei de Praia")
//  .setLocationLabel("Praia do Futuro - Fortaleza, CE")
//  .setDateLabel("30 Abr")
//  .setTagViewTextColor(text: "Jogos",textColor: .black,backgroundColor: .green)
//  .setAvatars(["","",""],2)
//  .setDetailButtonTitle("Participar")
//  .setImage("imageCard3")


var mockEvents: [Event] = [
    eventMock1,
    eventMock1,
    eventMock1,
]
