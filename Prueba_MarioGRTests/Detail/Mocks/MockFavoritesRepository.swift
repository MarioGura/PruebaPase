//
//  MockFavoritesRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import Foundation
@testable import Prueba_MarioGR

final class MockFavoritesRepository: FavoritesRepositoryProtocol {
    func fetchFavorites() -> [Prueba_MarioGR.FavoriteCharacter] {
        return []
    }

    var favorites: Set<Int64> = []

    func addFavorite(character: CharacterDetailModel) throws {
        favorites.insert(Int64(character.id))
    }

    func removeFavorite(id: Int64) throws {
        favorites.remove(id)
    }

    func isFavorite(id: Int64) -> Bool {
        favorites.contains(id)
    }
}
