//
//  CharacterResponse.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/14/25.
//

import Foundation

struct CharacterResponse: Codable {
    struct Info: Codable { let count: Int; let pages: Int; let next: String?; let prev: String? }
    let info: Info
    let results: [CharacterModel]
}
