//
//  FavoritesRepositoryMock.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

final class FavoritesRepositoryMock: FavoritesRepositoryProtocol {
    
    var storedIds: Set<Int> = []

    func isFavorite(id: Int64) -> Bool { storedIds.contains(Int(id)) }
    func addFavorite(character: CharacterDetailModel) { storedIds.insert(Int(character.id)) }
    func removeFavorite(id: Int64) { storedIds.remove(Int(id)) }
    func fetchFavorites() -> [FavoriteCharacter] { [] }
}

final class SeenEpisodesRepositoryMock: SeenEpisodesRepositoryProtocol {
    
    var seen: Set<String> = []

    func isSeen(urlString: String) -> Bool { seen.contains(urlString) }
    func markSeen(urlString: String) { seen.insert(urlString) }
    func fetchSeenEpisodes() -> [SeenEpisodes] {[]}
    func unmarkSeen(urlString: String) throws { seen.remove(urlString) }
}
