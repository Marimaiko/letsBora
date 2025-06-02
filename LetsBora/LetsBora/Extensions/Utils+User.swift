//
//  Utils+User.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//

extension Utils {
    private static let userDefaultsUserKey = "loggedInUser"
    
    static func saveLoggedInUser(_ user: User) {
        print("saving user default: \(user)")
        addUserDefaults(value:user.toDict, key: userDefaultsUserKey)
    }
    
    static func getLoggedInUser() -> User? {
        guard let userDict = getUserDefaults(key: userDefaultsUserKey) as? [String: Any] else {
            return nil
        }
        return User(from: userDict)
    }
    static func removeLoggedInUser() {
        removeUserDefaults(key: userDefaultsUserKey)
    }
}
