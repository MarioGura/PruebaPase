//
//  FavoritesPage.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest

struct FavoritesPage {
    let app: XCUIApplication

    var title: XCUIElement { app.staticTexts["Favoritos"] }
    var list: XCUIElement { app.tables["FavoritesList"] }

    func tapCharacter(named name: String) {
        app.staticTexts[name].tap()
    }
}
