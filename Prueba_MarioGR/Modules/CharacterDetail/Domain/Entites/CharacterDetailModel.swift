//
//  CharacterDetailModel.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation

struct CharacterDetailModel: Identifiable, Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct Origin: Codable {
        let name: String
        let url: String
    }
    
    struct Location: Codable {
        let name: String
        let url: String
    }
}

