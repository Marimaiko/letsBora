//
//  FirebaseAuthError.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//
import Foundation

enum FirebaseAuthErrorCode: String {
    case userNotFound = "ERROR_USER_NOT_FOUND"
    case unknown
    
    init(from rawValue: String) {
        self = FirebaseAuthErrorCode(rawValue: rawValue) ?? .unknown
    }
}

struct FirebaseAuthError: Error {
    static let userInfoKey = "FIRAuthErrorUserInfoNameKey"
    
    let code: FirebaseAuthErrorCode
    let message: String?
    
    init(from error: Error) {
        let nsError = error as NSError
        let userInfo = nsError.userInfo
        
        // Extract Firebase error code string
        let codeString = userInfo[FirebaseAuthError.userInfoKey] as? String ?? ""
        self.code = FirebaseAuthErrorCode(from: codeString)
        print("Error Firebase Code \(codeString)")
        
        // Optional message from Firebase (can customize)
        self.message = nsError.localizedDescription
        print("Error Firebase \(message ?? "")")
    }
}
