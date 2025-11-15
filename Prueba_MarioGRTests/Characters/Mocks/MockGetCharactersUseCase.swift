//
//  GetCharactersUseCaseTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
@testable import Prueba_MarioGR

final class MockGetCharactersUseCase: GetCharactersUseCaseProtocol {
    
    var mockResult: [CharacterModel] = []
    var shouldThrowError: Bool = false
    
    func execute(page: Int, name: String?, status: String?, species: String?) async throws -> [CharacterModel] {
        
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        
        return mockResult
    }
}
