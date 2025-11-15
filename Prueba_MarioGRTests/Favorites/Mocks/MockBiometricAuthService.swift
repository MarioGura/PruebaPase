//
//  MockBiometricAuthService.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import Foundation

final class MockBiometricAuthService: BiometricAuthServiceProtocol {
    var shouldSucceed = true

    func authenticate(completion: @escaping (Result<Bool, Error>) -> Void) {
        if shouldSucceed {
            completion(.success(true))
        } else {
            completion(.failure(NSError(domain: "Auth", code: -1)))
        }
    }
}
