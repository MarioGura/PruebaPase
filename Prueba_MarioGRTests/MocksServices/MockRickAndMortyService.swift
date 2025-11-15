//
//  Untitled.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
@testable import Prueba_MarioGR

final class MockRickAndMortyService: RickAndMortyServiceProtocol {

    var mockCharactersResponse: CharacterResponse?
    var mockDetailResponse: CharacterDetailModel?
    var shouldThrowError: Bool = false
    
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> CharacterResponse {
        
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockCharactersResponse!
    }
    
    func fetchCharacterDetail(id: Int) async throws -> CharacterDetailModel {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockDetailResponse!
    }
}


