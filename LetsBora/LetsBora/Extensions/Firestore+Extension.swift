//
//  Firestore+Extension.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/07/25.
//

import FirebaseFirestore

extension DocumentSnapshot {
    func decoded<T: Decodable>(as type: T.Type) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: self.data() ?? [:])
        return try JSONDecoder().decode(T.self, from: data)
    }
}
