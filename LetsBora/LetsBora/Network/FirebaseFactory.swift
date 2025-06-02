//
//  Firebase.swift
//  LetsBora
//
//  Created by Davi Paiva on 28/05/25.
//
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

import GoogleSignIn

struct FirebaseFactory {
#if EMULATE_FIREBASE
    static let defaultUseEmulatorFlag: Bool = true
#else
    static let defaultUseEmulatorFlag: Bool = false
#endif
    
    
    /// Configures Firebase if it's not already configured
    static func configureIfNeeded() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
            print("Firebase configured in \(defaultUseEmulatorFlag ? "emulator mode" : "production mode")")
        }
    }
    
    /// Creates and configures a Firestore instance
    static func makeFirestore(useEmulator: Bool = defaultUseEmulatorFlag) -> Firestore {
        configureIfNeeded()
        let firestore = Firestore.firestore()
        
        if useEmulator {
            let settings = firestore.settings
            settings.host = "127.0.0.1:8080"
            settings.isSSLEnabled = false
            firestore.settings = settings
        }
        
        return firestore
    }
    
    private static func getConfigGoogle()
    -> GIDConfiguration? {
        
        configureIfNeeded()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil}
        
        return GIDConfiguration(clientID: clientID)
    }
    
    static func makeGoogleSignIn() -> GIDSignIn? {
        guard let config = getConfigGoogle() else { return nil }
        GIDSignIn.sharedInstance.configuration = config
        
        return GIDSignIn.sharedInstance
    }
    /// Returns a configured Auth instance
    static func makeAuth(useEmulator: Bool = defaultUseEmulatorFlag) -> Auth {
        configureIfNeeded()
        let auth = Auth.auth()
        
        if useEmulator {
            auth.useEmulator(withHost: "127.0.0.1", port: 9099)
        }
        
        return auth
    }
}
