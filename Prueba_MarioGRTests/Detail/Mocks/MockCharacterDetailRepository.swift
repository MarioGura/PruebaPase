//
//  MockCharacterDetailRepository.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import Foundation
@testable import Prueba_MarioGR

final class MockCharacterDetailRepository: CharacterDetailRepositoryProtocol {

    var mockDetail: CharacterDetailModel?
    var shouldThrow = false

    func getCharacterDetail(id: Int) async throws -> CharacterDetailModel {
        if shouldThrow { throw URLError(.badServerResponse) }
        return mockDetail!
    }
}
