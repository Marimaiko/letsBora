//
//  Utils.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//
import Foundation
class Utils {
    static func addUserDefaults(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func removeUserDefaults(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getUserDefaults(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
}
