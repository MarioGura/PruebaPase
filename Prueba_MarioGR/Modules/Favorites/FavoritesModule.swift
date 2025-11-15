//
//  FavoritesModule.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Swinject

struct FavoritesModule {
    static func setup(container: Container) {
        
        // MARK: - Repository
        container.register(FavoritesPersistanceRepositoryProtocol.self) { _ in
            FavoritesPersistanceRepository()
        }
        
        // MARK: - Use Case
        container.register(GetFavoritesUseCaseProtocol.self) { r in
            guard let repository = r.resolve(FavoritesPersistanceRepositoryProtocol.self) else {
                fatalError("No se pudo resolver FavoritesPersistanceRepositoryProtocol")
            }
            return GetFavoritesUseCase(repository: repository)
        }
        
        // MARK: - ViewModel
        container.register(FavoritesViewModel.self) { r in
            guard let useCase = r.resolve(GetFavoritesUseCaseProtocol.self) else {
                fatalError("No se pudo resolver GetFavoritesUseCaseProtocol")
            }
            return FavoritesViewModel(getFavoritesUseCase: useCase)
        }
        
        // MARK: - View
        container.register(FavoritesView.self) { r in
            guard let viewModel = r.resolve(FavoritesViewModel.self) else {
                fatalError("No se pudo resolver FavoritesViewModel")
            }
            return FavoritesView(viewModel: viewModel)
        }
    }
}
