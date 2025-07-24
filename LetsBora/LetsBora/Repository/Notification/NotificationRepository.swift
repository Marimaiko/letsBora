//
//  NotificationRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 24/07/25.
//

import Foundation

enum NotificationError: Error {
    case notFound
    case creationFailed
    case retrievalFailed
    case updateFailed
    case deletionFailed
}

protocol NotificationRepository {
    func create(_ notification: Notification) async throws -> Void
    func retrieve(for id: String) async throws -> Notification?
    func retrieveAll() async throws -> [Notification]
    func update(_ notification: Notification) async throws -> Void
    func delete(for id: String) async throws -> Void
}
