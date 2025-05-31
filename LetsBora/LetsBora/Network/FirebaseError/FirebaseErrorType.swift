//
//  FirebaseErrorEnum.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//

// Auth
enum FirebaseAuthErrorCode: String, FirebaseErrorCode {
    case userNotFound = "ERROR_USER_NOT_FOUND"
    case invalidPassword = "ERROR_WRONG_PASSWORD"
    case incorrectCredentials = "ERROR_INVALID_CREDENTIAL"
    case unknown

    init(from rawValue: String) {
        self = FirebaseAuthErrorCode(rawValue: rawValue) ?? .unknown
    }
}
