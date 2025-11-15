//
//  APIError.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez  on 11/13/25.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL es inválida."
        case .invalidResponse:
            return "Respuesta del servidor inválida."
        case .decodingError(let error):
            return "Error al decodificar: \(error.localizedDescription)"
        case .unknown(let error):
            return "Error desconocido: \(error.localizedDescription)"
        }
    }
}
