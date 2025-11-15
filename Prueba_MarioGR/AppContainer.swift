//
//  AppContainer.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import Swinject

final class AppContainer {
    static let shared = AppContainer()
    let container = Container()
    
    private init() {}
    
    func setup() {
        container.removeAll()
        // MARK: - Services
        container.register(RickAndMortyServiceProtocol.self) { _ in
            RickAndMortyService()
        }
        
        // MARK: - Repositories
        container.register(CharacterRepositoryProtocol.self) { r in
            guard let service = r.resolve(RickAndMortyServiceProtocol.self) else {
                fatalError("No se pudo resolver RickAndMortyServiceProtocol")
            }
            return CharacterRepository(service: service)
        }
        
        container.register(FavoritesRepositoryProtocol.self) { _ in
            FavoritesRepository(context: PersistenceController.shared.container.viewContext)
        }
        
        container.register(SeenEpisodesRepositoryProtocol.self) { _ in
            SeenEpisodesRepository(context: PersistenceController.shared.container.viewContext)
        }
        
        // MARK: - Use Cases
        container.register(GetCharactersUseCaseProtocol.self) { r in
            guard let repo = r.resolve(CharacterRepositoryProtocol.self) else {
                fatalError("No se pudo resolver CharacterRepositoryProtocol")
            }
            return GetCharactersUseCase(repository: repo)
        }
        
        // MARK: - ViewModels
        container.register(CharacterViewModel.self) { r in
            guard let useCase = r.resolve(GetCharactersUseCaseProtocol.self) else {
                fatalError("No se pudo resolver GetCharactersUseCaseProtocol")
            }
            return CharacterViewModel(getCharactersUseCase: useCase)
        }
        
        // MARK: - Modules
        CharacterDetailModule.setup(container: container)
        FavoritesModule.setup(container: container)
    }
}
