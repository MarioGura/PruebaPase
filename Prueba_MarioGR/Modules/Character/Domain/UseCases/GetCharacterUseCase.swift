//
//  GetCharacterUseCase.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import Foundation

protocol GetCharactersUseCaseProtocol {
    func execute(page: Int, name: String?, status: String?, species: String?) async throws -> [CharacterModel]
}

final class GetCharactersUseCase: GetCharactersUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int, name: String?, status: String?, species: String?) async throws -> [CharacterModel] {
        try await repository.fetchCharacters(page: page, name: name, status: status, species: species)
    }
}
