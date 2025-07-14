//
//  Encodable+toDictionary.swift.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/07/25.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        
        guard let dictionary = jsonObject as? [String: Any] else {
            throw NSError(
                domain: "CodableError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON to Dictionary"]
            )
        }
        return dictionary
    }
}
