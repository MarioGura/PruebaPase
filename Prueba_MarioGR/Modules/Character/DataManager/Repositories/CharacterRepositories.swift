//
//  CharacterRepositories.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func fetchCharacters(page: Int, name: String?, status: String?, species: String?) async throws -> [CharacterModel]
}

final class CharacterRepository: CharacterRepositoryProtocol {
    private let service: RickAndMortyServiceProtocol

    init(service: RickAndMortyServiceProtocol) {
        self.service = service
    }

    func fetchCharacters(page: Int, name: String?, status: String?, species: String?) async throws -> [CharacterModel] {
        let response = try await service.fetchCharacters(page: page, name: name, status: status, species: species)
        return response.results
    }
}
