//
//  CharacterDetailRepositories.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez 170 on 11/13/25.
//

import Foundation

protocol CharacterDetailRepositoryProtocol {
    func getCharacterDetail(id: Int) async throws -> CharacterDetailModel
}

final class CharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let api: RickAndMortyServiceProtocol
    
    init(api: RickAndMortyServiceProtocol) {
        self.api = api
    }
    
    func getCharacterDetail(id: Int) async throws -> CharacterDetailModel {
        try await api.fetchCharacterDetail(id: id)
    }
}

