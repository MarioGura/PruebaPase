//
//  CharacterViewModelTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR

final class CharacterViewModelTests: XCTestCase {
    
    // MARK: - Helpers
    private func makeMockCharacters() -> [CharacterModel] {
        return [
            CharacterModel(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            CharacterModel(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
    }
    
    // MARK: - Tests
    
    func test_loadCharacters_success() async {
        // GIVEN
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.mockResult = makeMockCharacters()
        
        let viewModel = CharacterViewModel(getCharactersUseCase: mockUseCase)
        
        // WHEN
        await viewModel.loadCharacters()
        
        // THEN
        XCTAssertEqual(viewModel.characters.count, 2)
        XCTAssertEqual(viewModel.state, .loaded)
    }
    
    func test_loadCharacters_empty() async {
        // GIVEN
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.mockResult = []   // ← vacío
        
        let viewModel = CharacterViewModel(getCharactersUseCase: mockUseCase)
        
        // WHEN
        await viewModel.loadCharacters()
        
        // THEN
        XCTAssertEqual(viewModel.state, .empty)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }

    func test_loadCharacters_failure() async {
        // GIVEN
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.shouldThrowError = true
        
        let viewModel = CharacterViewModel(getCharactersUseCase: mockUseCase)
        
        // WHEN
        await viewModel.loadCharacters()
        
        // THEN
        if case .error(_) = viewModel.state {
            XCTAssertTrue(true) // ok
        } else {
            XCTFail(" Expected state .error")
        }
    }

    func test_loadNextIfNeeded_pagination() async {
        // GIVEN
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.mockResult = makeMockCharacters()
        
        let viewModel = CharacterViewModel(getCharactersUseCase: mockUseCase)

        // Load page 1
        await viewModel.loadCharacters()

        // Load page 2
        mockUseCase.mockResult = [
            CharacterModel(id: 3, name: "Summer", status: "Alive", species: "Human", image: "")
        ]

        // WHEN
        let lastItem = viewModel.characters.last!
        await viewModel.loadNextIfNeeded(currentItem: lastItem)
        
        // THEN
        XCTAssertEqual(viewModel.characters.count, 3)
    }

    func test_resetFiltersAndReload() async {
        // GIVEN
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.mockResult = makeMockCharacters()
        
        let viewModel = CharacterViewModel(getCharactersUseCase: mockUseCase)
        
        viewModel.searchText = "Rick"
        viewModel.selectedStatus = "Alive"
        viewModel.selectedSpecies = "Human"
        
        // WHEN
        await viewModel.resetFiltersAndReload()
        
        // THEN
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.selectedStatus, "")
        XCTAssertEqual(viewModel.selectedSpecies, "")
        XCTAssertEqual(viewModel.characters.count, 2)
        XCTAssertEqual(viewModel.state, .loaded)
    }
}
