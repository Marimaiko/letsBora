//
//  Tag.swift
//  LetsBora
//
//  Created by Davi Paiva on 07/04/25.
//

import UIKit
enum TagKeys {
    static let collectionName = "tags"
    static let id = "tagId"
    static let title = "title"
    static let colorHex = "colorHex"
    static let bgColorHex = "bgColorHex"
}
struct Tag: Identifiable {
    var id:String = UUID().uuidString
    var title: String
    var color: String
    var bgColor: String
    
    init(
        title: String,
        color: String,
        bgColor: String
    ) {
        self.title = title
        self.color = color
        self.bgColor = bgColor
    }
    init?(from data: [String: Any]) {
        guard let id = data[TagKeys.id] as? String,
              let title = data[TagKeys.title] as? String,
              let colorHex = data[TagKeys.colorHex] as? String,
              let bgColorHex = data[TagKeys.bgColorHex] as? String
        else { return nil }
        
        self.id = id
        self.title = title
        self.color = colorHex
        self.bgColor  = bgColorHex
    }
    
    
}
