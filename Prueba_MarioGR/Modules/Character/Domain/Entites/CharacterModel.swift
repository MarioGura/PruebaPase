//
//  Character.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import Foundation

struct CharacterModel: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}
