//
//  FavoritesRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import CoreData
import Foundation

protocol FavoritesRepositoryProtocol {
    func addFavorite(character: CharacterDetailModel) throws
    func removeFavorite(id: Int64) throws
    func isFavorite(id: Int64) -> Bool
    func fetchFavorites() -> [FavoriteCharacter]
}

final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func addFavorite(character: CharacterDetailModel) throws {
        let favorite = FavoriteCharacter(context: context)
        favorite.id = Int64(character.id)
        favorite.name = character.name
        favorite.image = character.image
        favorite.status = character.status
        favorite.species = character.species
        favorite.createdAt = Date()
        try context.save()
    }

    func removeFavorite(id: Int64) throws {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        if let result = try context.fetch(request).first {
            context.delete(result)
            try context.save()
        }
    }

    func isFavorite(id: Int64) -> Bool {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return (try? context.count(for: request)) ?? 0 > 0
    }

    func fetchFavorites() -> [FavoriteCharacter] {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}
