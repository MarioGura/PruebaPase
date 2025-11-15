//
//  GetCharactersUseCaseTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR

final class GetCharactersUseCaseTests: XCTestCase {
    
    func test_execute_success() async throws {
        // GIVEN
        let mockRepo = MockCharacterRepository()
        mockRepo.mockCharacters = [
            CharacterModel(id: 1, name: "Rick", status: "Alive", species: "Human", image: "")
        ]
        
        let useCase = GetCharactersUseCase(repository: mockRepo)
        
        // WHEN
        let result = try await useCase.execute(page: 1, name: nil, status: nil, species: nil)
        
        // THEN
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Rick")
    }
    
    func test_execute_failure() async {
        // GIVEN
        let mockRepo = MockCharacterRepository()
        mockRepo.shouldThrowError = true
        
        let useCase = GetCharactersUseCase(repository: mockRepo)
        
        // WHEN / THEN
        do {
            _ = try await useCase.execute(page: 1, name: nil, status: nil, species: nil)
            XCTFail("Debe lanzar error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
