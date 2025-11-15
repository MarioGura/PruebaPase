//
//  MockSeenEpisodesRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import Foundation
@testable import Prueba_MarioGR

struct MockSeenEpisode {
    let urlString: String
}

final class MockSeenEpisodesRepository: SeenEpisodesRepositoryProtocol {
    func isSeen(urlString: String) -> Bool {
        return false
    }
    
    func fetchSeenEpisodes() -> [Prueba_MarioGR.SeenEpisodes] {
        return []
    }
    

    var seen: Set<String> = []

    func markSeen(urlString: String) throws {
        seen.insert(urlString)
    }

    func unmarkSeen(urlString: String) throws {
        seen.remove(urlString)
    }

    func fetchSeenEpisodes() -> [MockSeenEpisode] {
        seen.map { MockSeenEpisode(urlString: $0) }
    }
}
