//
//  CharacterDetail.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Swinject

import Swinject

struct CharacterDetailModule {
    static func setup(container: Container) {
        
        // MARK: - Service
        container.register(RickAndMortyServiceProtocol.self) { _ in
            RickAndMortyService()
        }
        
        // MARK: - Repository
        container.register(CharacterDetailRepositoryProtocol.self) { r in
            guard let api = r.resolve(RickAndMortyServiceProtocol.self) else {
                fatalError("No se pudo resolver RickAndMortyServiceProtocol")
            }
            return CharacterDetailRepository(api: api)
        }
        
        // MARK: - Use Case
        container.register(GetCharacterDetailUseCaseProtocol.self) { r in
            guard let repository = r.resolve(CharacterDetailRepositoryProtocol.self) else {
                fatalError("No se pudo resolver CharacterDetailRepositoryProtocol")
            }
            return GetCharacterDetailUseCase(repository: repository)
        }
        
        // MARK: - ViewModel
        container.register(CharacterDetailViewModel.self) { r in
            guard let useCase = r.resolve(GetCharacterDetailUseCaseProtocol.self) else {
                fatalError("No se pudo resolver GetCharacterDetailUseCaseProtocol")
            }
            guard let favoritesRepo = r.resolve(FavoritesRepositoryProtocol.self) else {
                fatalError("No se pudo resolver FavoritesRepositoryProtocol")
            }
            guard let seenRepo = r.resolve(SeenEpisodesRepositoryProtocol.self) else {
                fatalError("No se pudo resolver SeenEpisodesRepositoryProtocol")
            }
            
            return CharacterDetailViewModel(
                getCharacterDetailUseCase: useCase,
                favoritesRepo: favoritesRepo,
                seenRepo: seenRepo
            )
        }
    }
}
