//
//  FavoritesPersistanceRepositoryTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
import CoreData
@testable import Prueba_MarioGR

final class FavoritesPersistanceRepositoryTests: XCTestCase {

    var testStack: CoreDataTestStack!
    var repository: FavoritesPersistanceRepository!

    override func setUp() {
        super.setUp()
        testStack = CoreDataTestStack()
        repository = FavoritesPersistanceRepository(context: testStack.context)
    }

    override func tearDown() {
        testStack = nil
        repository = nil
        super.tearDown()
    }

    // MARK: - Helpers
    private func insertFavorite(id: Int64, name: String, status: String, species: String, image: String) {
        let fav = FavoriteCharacter(context: testStack.context)
        fav.id = id
        fav.name = name
        fav.status = status
        fav.species = species
        fav.image = image
    }

    // MARK: - TESTS

    func test_fetchFavorites_returnsFavoritesCorrectly() {
        // GIVEN
        insertFavorite(id: 1, name: "Rick", status: "Alive", species: "Human", image: "rick.png")
        insertFavorite(id: 2, name: "Morty", status: "Alive", species: "Human", image: "morty.png")

        try? testStack.context.save()

        // WHEN
        let result = repository.fetchFavorites()

        // THEN
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Rick")
        XCTAssertEqual(result.last?.name, "Morty")
    }

    func test_fetchFavorites_returnsEmptyArrayWhenNoData() {
        // WHEN
        let result = repository.fetchFavorites()

        // THEN
        XCTAssertTrue(result.isEmpty)
    }

    func test_fetchFavorites_handlesFetchErrorGracefully() {
        // GIVEN
        testStack.context.reset()

        // WHEN
        let result = repository.fetchFavorites()

        // THEN
        XCTAssertTrue(result.isEmpty)
    }
}
