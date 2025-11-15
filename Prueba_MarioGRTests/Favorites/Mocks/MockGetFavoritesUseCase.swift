//
//  MockGetFavoritesUseCase.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

final class MockGetFavoritesUseCase: GetFavoritesUseCaseProtocol {
    var result: [CharacterModel] = []

    func execute() -> [CharacterModel] {
        result
    }
}
