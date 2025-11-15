//
//  FavoritesViewModelTests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest
@testable import Prueba_MarioGR

final class FavoritesViewModelTests: XCTestCase {

    func test_loadFavorites_authenticatedLoadsData() {
        // GIVEN
        let mockUseCase = MockGetFavoritesUseCase()
        mockUseCase.result = [
            CharacterModel(id: 1, name: "Rick", status: "Alive", species: "Human", image: "rick.png")
        ]

        let auth = MockBiometricAuthService()
        auth.shouldSucceed = true

        let viewModel = FavoritesViewModel(
            getFavoritesUseCase: mockUseCase,
            authService: auth
        )

        // WHEN
        let expectation = XCTestExpectation(description: "Auth completed")
        viewModel.authenticate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewModel.loadFavorites()
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        // THEN
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertEqual(viewModel.favorites.count, 1)
        XCTAssertEqual(viewModel.favorites.first?.name, "Rick")
    }

    func test_loadFavorites_notAuthenticated_doesNotLoad() {
        // GIVEN
        let mockUseCase = MockGetFavoritesUseCase()
        mockUseCase.result = [
            CharacterModel(id: 2, name: "Morty", status: "Alive", species: "Human", image: "morty.png")
        ]

        let auth = MockBiometricAuthService()
        auth.shouldSucceed = false

        let viewModel = FavoritesViewModel(
            getFavoritesUseCase: mockUseCase,
            authService: auth
        )

        // WHEN
        viewModel.authenticate()

        // THEN
        XCTAssertFalse(viewModel.isAuthenticated)

        viewModel.loadFavorites()

        XCTAssertEqual(viewModel.favorites.count, 0)
    }

    func test_authenticationFailure_setsErrorMessage() {
        // GIVEN
        let mockUseCase = MockGetFavoritesUseCase()
        let auth = MockBiometricAuthService()
        auth.shouldSucceed = false

        let viewModel = FavoritesViewModel(
            getFavoritesUseCase: mockUseCase,
            authService: auth
        )

        // WHEN
        viewModel.authenticate()

        // THEN
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isAuthenticated)
    }

    func test_loadFavorites_authenticated_noFavoritesFound() {
        // GIVEN
        let mockUseCase = MockGetFavoritesUseCase() // vacío
        let auth = MockBiometricAuthService()
        auth.shouldSucceed = true

        let viewModel = FavoritesViewModel(
            getFavoritesUseCase: mockUseCase,
            authService: auth
        )

        // WHEN
        let expectation = XCTestExpectation(description: "Auth completed")
        viewModel.authenticate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            viewModel.loadFavorites()
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        // THEN
        XCTAssertEqual(viewModel.favorites.count, 0)
    }
}
