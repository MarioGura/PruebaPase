//
//  CharacterDetailViewModelTests2.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR
import CoreLocation

final class CharacterDetailViewModelTests: XCTestCase {

    var sut: CharacterDetailViewModel!
    var mockUseCase: MockGetCharacterDetailUseCase!
    var mockFavorites: MockFavoritesRepository!
    var mockSeen: MockSeenEpisodesRepository!

    override func setUp() {
        mockUseCase = MockGetCharacterDetailUseCase()
        mockFavorites = MockFavoritesRepository()
        mockSeen = MockSeenEpisodesRepository()

        sut = CharacterDetailViewModel(
            getCharacterDetailUseCase: mockUseCase,
            favoritesRepo: mockFavorites,
            seenRepo: mockSeen
        )
    }

    func test_fetchDetail_success() async {
        // Arrange
        let model = CharacterDetailModel(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: .init(name: "Earth", url: ""),
            location: .init(name: "Citadel", url: ""),
            image: "",
            episode: ["episode1"],
            url: "",
            created: ""
        )

        mockUseCase.mockDetail = model

        // Act
        await sut.fetchDetail(id: 1)

        // Assert
        XCTAssertNotNil(sut.detail)
        XCTAssertEqual(sut.detail?.name, "Rick")
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }

    func test_fetchDetail_error() async {
        mockUseCase.shouldThrow = true

        await sut.fetchDetail(id: 1)

        XCTAssertNotNil(sut.errorMessage)
        XCTAssertNil(sut.detail)
        XCTAssertFalse(sut.isLoading)
    }

    func test_toggleFavorite_add() async {
        // Arrange
        let model = CharacterDetailModel(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "",
            origin: .init(name: "", url: ""),
            location: .init(name: "", url: ""),
            image: "",
            episode: [],
            url: "",
            created: ""
        )
        mockUseCase.mockDetail = model
        await sut.fetchDetail(id: 1)

        // Act
        await sut.toggleFavorite()

        // Assert
        XCTAssertTrue(sut.isFavorite)
        XCTAssertTrue(mockFavorites.favorites.contains(1))
    }

    func test_toggleFavorite_remove() async {
        // Arrange
        let model = CharacterDetailModel(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "",
            origin: .init(name: "", url: ""),
            location: .init(name: "", url: ""),
            image: "",
            episode: [],
            url: "",
            created: ""
        )
        mockUseCase.mockDetail = model
        await sut.fetchDetail(id: 1)

        // Simula que ya es favorito
        sut.isFavorite = true
        mockFavorites.favorites = [1]

        // Act
        await sut.toggleFavorite()

        // Assert
        XCTAssertFalse(sut.isFavorite)
        XCTAssertFalse(mockFavorites.favorites.contains(1))
    }

    func test_toggleEpisodeSeen_mark() {
        sut.toggleEpisodeSeen("episode1")

        XCTAssertTrue(sut.seenEpisodes.contains("episode1"))
        XCTAssertTrue(mockSeen.seen.contains("episode1"))
    }

    func test_toggleEpisodeSeen_unmark() {
        // Arrange
        mockSeen.seen = ["episode1"]
        sut.seenEpisodes = ["episode1"]

        // Act
        sut.toggleEpisodeSeen("episode1")

        // Assert
        XCTAssertFalse(sut.seenEpisodes.contains("episode1"))
        XCTAssertFalse(mockSeen.seen.contains("episode1"))
    }
}
