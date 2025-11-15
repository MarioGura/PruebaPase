//
//  SeenEpisodesRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//
import CoreData

protocol SeenEpisodesRepositoryProtocol {
    func markSeen(urlString: String) throws
    func unmarkSeen(urlString: String) throws
    func isSeen(urlString: String) -> Bool
    func fetchSeenEpisodes() -> [SeenEpisodes]
}

final class SeenEpisodesRepository: SeenEpisodesRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func markSeen(urlString: String) throws {
        let seen = SeenEpisodes(context: context)
        seen.urlString = urlString
        try context.save()
    }

    func unmarkSeen(urlString: String) throws {
        let request: NSFetchRequest<SeenEpisodes> = SeenEpisodes.fetchRequest()
        request.predicate = NSPredicate(format: "urlString == %@", urlString)
        if let result = try context.fetch(request).first {
            context.delete(result)
            try context.save()
        }
    }

    func isSeen(urlString: String) -> Bool {
        let request: NSFetchRequest<SeenEpisodes> = SeenEpisodes.fetchRequest()
        request.predicate = NSPredicate(format: "urlString == %@", urlString)
        return (try? context.count(for: request)) ?? 0 > 0
    }

    func fetchSeenEpisodes() -> [SeenEpisodes] {
        let request: NSFetchRequest<SeenEpisodes> = SeenEpisodes.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}
