//
//  TagRepository.swift
//  LetsBora
//
//  Created by Davi Paiva on 01/06/25.
//
import Foundation

enum TagRepositoryError: Error, LocalizedError {
    case  retrieveAllFailed
    
    var errorDescription: String? {
        switch self {
        case .retrieveAllFailed:
            return "Failed to retrieve tags."
        }
    }
    
}
protocol TagRepository {
    func retrieveAll() async throws -> [Tag]
}
