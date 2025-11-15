//
//  FavoritesRepositories.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
import CoreData

protocol FavoritesPersistanceRepositoryProtocol {
    func fetchFavorites() -> [CharacterModel]
}

final class FavoritesPersistanceRepository: FavoritesPersistanceRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func fetchFavorites() -> [CharacterModel] {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]

        guard let results = try? context.fetch(request) else { return [] }

        return results.compactMap { fav in
            CharacterModel(id: Int(fav.id),
                           name: fav.name,
                           status: fav.status ?? "",
                           species: fav.species ?? "",
                           image: fav.image ?? "")
        }
    }

}

