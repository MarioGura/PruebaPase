//
//  RickAndMortyServices.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import Foundation

protocol RickAndMortyServiceProtocol {
    func fetchCharacters(page: Int, name: String?, status: String?, species: String?) async throws -> CharacterResponse
    func fetchCharacterDetail(id: Int) async throws -> CharacterDetailModel
}

final class RickAndMortyService: RickAndMortyServiceProtocol {
    
    let baseUrl: String = "https://rickandmortyapi.com/api"
    
    func fetchCharacters(
        page: Int,
        name: String?,
        status: String?,
        species: String?
    ) async throws -> CharacterResponse {
        
        guard var components = URLComponents(string: self.baseUrl + "/character") else {
            throw URLError(.badURL)
        }
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let status = status, !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        if let species = species, !species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: species))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(CharacterResponse.self, from: data)
    }

    func fetchCharacterDetail(id: Int) async throws -> CharacterDetailModel {
        guard let url = URL(string: "\(self.baseUrl)/character/\(id)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(CharacterDetailModel.self, from: data)
    }
}
