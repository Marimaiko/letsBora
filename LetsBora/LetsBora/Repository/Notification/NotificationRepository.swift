//
//  NotificationRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 24/07/25.
//

import Foundation

enum NotificationError: LocalizedError {
    case notFound(String = "Notification not found.")
    case creationFailed(String = "Failed to create the notification.")
    case retrievalFailed(String = "Failed to retrieve the notification.")
    case updateFailed(String = "Failed to update the notification.")
    case deletionFailed(String = "Failed to delete the notification.")

    var errorDescription: String? {
        switch self {
        case .notFound(let message),
             .creationFailed(let message),
             .retrievalFailed(let message),
             .updateFailed(let message),
             .deletionFailed(let message):
            return message
        }
    }
}
protocol NotificationRepository {
    func create(_ notification: Notification) async throws -> Void
    func retrieve(for id: String) async throws -> Notification?
    func retrieveAll() async throws -> [Notification]
    func update(_ notification: Notification) async throws -> Void
    func delete(for id: String) async throws -> Void
}
