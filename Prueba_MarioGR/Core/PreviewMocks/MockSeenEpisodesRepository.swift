//
//  MockSeenEpisodesRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

final class MockSeenEpisodesRepository: SeenEpisodesRepositoryProtocol {
    func markSeen(urlString: String) throws {}
    func unmarkSeen(urlString: String) throws {}
    func isSeen(urlString: String) -> Bool { false }
    func fetchSeenEpisodes() -> [SeenEpisodes] { [] }
}
