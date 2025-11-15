//
//  BiometricAuthService.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import LocalAuthentication
import Foundation

final class BiometricAuthService: BiometricAuthServiceProtocol {
    func authenticate(completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Accede a tus personajes favoritos"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        completion(.success(true))
                    } else {
                        completion(.failure(authError ?? NSError(domain: "BiometricAuth", code: -1)))
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(.success(true))
            }
        }
    }
}

