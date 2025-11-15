//
//  MockFavoritesPersistanceRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

final class MockFavoritesPersistanceRepository: FavoritesPersistanceRepositoryProtocol {
    var mockFavorites: [CharacterModel] = []

    func fetchFavorites() -> [CharacterModel] {
        mockFavorites
    }
}
