//
//  CharacterRepositoryTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import XCTest
@testable import Prueba_MarioGR

final class CharacterRepositoryTests: XCTestCase {
    
    func test_fetchCharacters_success() async throws {
        // GIVEN
        let mockService = MockRickAndMortyService()
        mockService.mockCharactersResponse = CharacterResponse(
            info: .init(count: 1, pages: 1, next: nil, prev: nil),
            results: [
                CharacterModel(id: 1, name: "Rick", status: "Alive", species: "Human", image: "")
            ]
        )
        
        let repo = CharacterRepository(service: mockService)
        
        // WHEN
        let result = try await repo.fetchCharacters(page: 1, name: nil, status: nil, species: nil)
        
        // THEN
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Rick")
    }
    
    func test_fetchCharacters_failure() async {
        // GIVEN
        let mockService = MockRickAndMortyService()
        mockService.shouldThrowError = true
        let repo = CharacterRepository(service: mockService)
        
        // WHEN / THEN
        do {
            _ = try await repo.fetchCharacters(page: 1, name: nil, status: nil, species: nil)
            XCTFail("Debe lanzar error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}

