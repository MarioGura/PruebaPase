//
//  CharacterDetailPage.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import XCTest

struct CharacterDetailPage {
    let app: XCUIApplication

    var favoriteButton: XCUIElement { app.buttons["FavoritoButton"] }
    var episodesList: XCUIElement { app.tables["EpisodeList"] }

    func tapFavorite() {
        favoriteButton.tap()
    }
}
