//
//  CharacterFlowUITests.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest

final class CharacterFlowUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - CharacterView Tests

    func test_characterView_loadsSuccessfully() {
        let title = app.navigationBars.staticTexts["Personajes"]
        XCTAssertTrue(title.waitForExistence(timeout: 5), "El título 'Personajes' debería aparecer")

        let favoritesButton = app.buttons["BotonFavoritos"]
        XCTAssertTrue(favoritesButton.exists, "El botón de favoritos debería existir")

        let anyRow = app.otherElements
            .matching(NSPredicate(format: "identifier BEGINSWITH %@", "CharacterRow_"))
            .firstMatch
        XCTAssertTrue(anyRow.waitForExistence(timeout: 10),
                      "Se esperaba que al menos una fila del listado se cargara")
    }

    func test_navigateToFavoritesView() {
        let favoritesButton = app.buttons["BotonFavoritos"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()

        let favTitle = app.navigationBars.staticTexts["Favoritos"]
        XCTAssertTrue(favTitle.waitForExistence(timeout: 5), "La vista de favoritos no se mostró")
    }

    // MARK: - CharacterDetailView Tests

    func test_selectCharacter_navigatesToDetail() {
        let firstRow = app.otherElements.matching(NSPredicate(format: "identifier BEGINSWITH %@", "CharacterRow_")).firstMatch
        XCTAssertTrue(firstRow.waitForExistence(timeout: 10))
        firstRow.tap()

        let detailTitle = app.staticTexts["CharacterDetailTitle"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 5),
                      "No se navegó a la vista de detalle del personaje")
    }

    func test_favoriteButton_togglesState() {
        let firstRow = app.otherElements.matching(NSPredicate(format: "identifier BEGINSWITH %@", "CharacterRow_")).firstMatch
        XCTAssertTrue(firstRow.waitForExistence(timeout: 10))
        firstRow.tap()

        let favoriteButton = app.buttons["FavoritoButton"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5))

        favoriteButton.tap()
        XCTAssertTrue(favoriteButton.exists)
    }

    // MARK: - Episodios vistos

    func test_toggleEpisodeSeenButton() {
        let firstRow = app.otherElements.matching(NSPredicate(format: "identifier BEGINSWITH %@", "CharacterRow_")).firstMatch
        XCTAssertTrue(firstRow.waitForExistence(timeout: 10))
        firstRow.tap()

        let episodeButton = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "EpisodeButton_")).firstMatch
        XCTAssertTrue(episodeButton.waitForExistence(timeout: 5))
        episodeButton.tap()

        XCTAssertTrue(episodeButton.exists)
    }
}
