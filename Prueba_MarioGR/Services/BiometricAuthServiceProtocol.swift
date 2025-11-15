//
//  BiometricAuthServiceProtocol.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

protocol BiometricAuthServiceProtocol {
    func authenticate(completion: @escaping (Result<Bool, Error>) -> Void)
}
