//
//  TagRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//
import Foundation

enum TagRepositoryError: Error, LocalizedError {
    case retrieveAllFailed
    case retrieveFailed
    case tagNotFound
    
    var errorDescription: String? {
        switch self {
        case .retrieveAllFailed:
            return "Failed to retrieve tags."
        case .retrieveFailed:
            return "Failed to retrieve tag."
        case .tagNotFound:
            return "Tag not found."
        }
    }
    
}
protocol TagRepository {
    func retrieve(for id: String) async throws -> Tag 
    func retrieveAll() async throws -> [Tag]
}
