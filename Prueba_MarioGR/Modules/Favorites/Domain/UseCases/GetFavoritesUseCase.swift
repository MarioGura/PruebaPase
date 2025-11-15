//
//  GetFavoritesUseCase.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

protocol GetFavoritesUseCaseProtocol {
    func execute() -> [CharacterModel]
}

final class GetFavoritesUseCase: GetFavoritesUseCaseProtocol {
    private let repository: FavoritesPersistanceRepositoryProtocol

    init(repository: FavoritesPersistanceRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> [CharacterModel] {
        repository.fetchFavorites()
    }
}

