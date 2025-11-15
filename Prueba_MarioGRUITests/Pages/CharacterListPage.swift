//
//  CharacterListPage.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest

struct CharacterListPage {
    let app: XCUIApplication

    var searchField: XCUIElement { app.searchFields["Buscar personaje"] }
    var favoritesButton: XCUIElement { app.buttons["BotonFavoritos"] }

    func tapCharacter(named name: String) {
        app.staticTexts[name].firstMatch.tap()
    }

    func search(_ text: String) {
        searchField.tap()
        searchField.typeText(text)
    }
}
