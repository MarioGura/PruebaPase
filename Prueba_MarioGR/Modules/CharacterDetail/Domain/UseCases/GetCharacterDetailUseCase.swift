//
//  GetCharacterDetailUseCase.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

protocol GetCharacterDetailUseCaseProtocol {
    func execute(id: Int) async throws -> CharacterDetailModel
}

final class GetCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol {
    private let repository: CharacterDetailRepositoryProtocol
    
    init(repository: CharacterDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> CharacterDetailModel {
        try await repository.getCharacterDetail(id: id)
    }
}
