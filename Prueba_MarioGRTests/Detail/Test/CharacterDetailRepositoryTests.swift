//
//  CharacterDetailRepositoryTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR

final class CharacterDetailRepositoryTests: XCTestCase {

    var sut: CharacterDetailRepository!
    var mockService: MockRickAndMortyService!

    override func setUp() {
        mockService = MockRickAndMortyService()
        sut = CharacterDetailRepository(api: mockService)
    }

    func test_getCharacterDetail_success() async throws {
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
            episode: [],
            url: "",
            created: ""
        )

        mockService.mockDetailResponse = model

        // Act
        let result = try await sut.getCharacterDetail(id: 1)

        // Assert
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Rick")
    }

    func test_getCharacterDetail_error() async {
        mockService.shouldThrowError = true

        do {
            _ = try await sut.getCharacterDetail(id: 1)
            XCTFail("Debió lanzar error y no lo hizo")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
