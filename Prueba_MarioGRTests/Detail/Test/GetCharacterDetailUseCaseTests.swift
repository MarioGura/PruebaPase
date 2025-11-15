//
//  GetCharacterDetailUseCaseTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR

final class GetCharacterDetailUseCaseTests: XCTestCase {

    var sut: GetCharacterDetailUseCase!
    var mockRepo: MockCharacterDetailRepository!

    override func setUp() {
        mockRepo = MockCharacterDetailRepository()
        sut = GetCharacterDetailUseCase(repository: mockRepo)
    }

    func test_execute_success() async throws {
        // Arrange
        let model = CharacterDetailModel(
            id: 42,
            name: "Morty",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: .init(name: "", url: ""),
            location: .init(name: "", url: ""),
            image: "",
            episode: [],
            url: "",
            created: ""
        )

        mockRepo.mockDetail = model

        // Act
        let result = try await sut.execute(id: 42)

        // Assert
        XCTAssertEqual(result.id, 42)
        XCTAssertEqual(result.name, "Morty")
    }

    func test_execute_error() async {
        mockRepo.shouldThrow = true

        do {
            _ = try await sut.execute(id: 22)
            XCTFail("Debió lanzar un error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
