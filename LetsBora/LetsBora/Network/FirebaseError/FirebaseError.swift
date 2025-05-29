//
//  FirebaseError.swift
//  LetsBora
//
//  Created by Davi Paiva on 29/05/25.
//
import Foundation

protocol FirebaseErrorCode: RawRepresentable, Equatable {
    init(from rawValue: String)
    var rawValue: String { get }
}

struct FirebaseError<Code: FirebaseErrorCode>: Error {
    let userInfoKey = "FIRAuthErrorUserInfoNameKey"

    let code: Code
    let message: String?

    init(from error: Error) {
        let nsError = error as NSError
        let userInfo = nsError.userInfo

        let codeString = userInfo[userInfoKey] as? String ?? ""
        self.code = Code(from: codeString)
        self.message = nsError.localizedDescription

        print("Firebase Error Code: \(codeString)")
        print("Firebase Error Message: \(message ?? "No message")")
    }
}
