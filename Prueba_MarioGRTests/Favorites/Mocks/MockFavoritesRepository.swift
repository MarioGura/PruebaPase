//
//  MockFavoritesRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

final class MockFavoritesRepository: FavoritesPersistanceRepositoryProtocol {
    
    var mockFavorites: [CharacterModel] = []

    func addFavorite(character: CharacterDetailModel) throws {}
    func removeFavorite(id: Int64) throws {}
    func isFavorite(id: Int64) -> Bool { false }
    func fetchFavorites() -> [CharacterModel] {
        return mockFavorites
    }
}
