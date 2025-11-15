//
//  GetCharacterDetailUseCaseMock.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation

final class MockGetCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol {
    var mockDetail: CharacterDetailModel?
    var shouldThrow = false

    func execute(id: Int) async throws -> CharacterDetailModel {
        if shouldThrow {
            throw URLError(.badServerResponse)
        }
        return mockDetail!
    }
}
