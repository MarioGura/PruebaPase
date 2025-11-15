//
//  GetFavoritesUseCaseTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR

final class GetFavoritesUseCaseTests: XCTestCase {

    func test_execute_returnsFavoritesFromRepository() {
        // GIVEN
        let mockRepo = MockFavoritesPersistanceRepository()
        mockRepo.mockFavorites = [
            CharacterModel(id: 1, name: "Rick", status: "Alive", species: "Human", image: "rick.png")
        ]

        let useCase = GetFavoritesUseCase(repository: mockRepo)

        // WHEN
        let result = useCase.execute()

        // THEN
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Rick")
        XCTAssertEqual(result.first?.species, "Human")
    }

    func test_execute_returnsEmptyArrayWhenRepositoryIsEmpty() {
        // GIVEN
        let mockRepo = MockFavoritesPersistanceRepository()
        mockRepo.mockFavorites = []

        let useCase = GetFavoritesUseCase(repository: mockRepo)

        // WHEN
        let result = useCase.execute()

        // THEN
        XCTAssertTrue(result.isEmpty)
    }
}

