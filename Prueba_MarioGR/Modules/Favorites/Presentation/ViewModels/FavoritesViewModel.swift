//
//  FavoritesViewModel.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
import LocalAuthentication

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [CharacterModel] = []
    @Published var isAuthenticated: Bool = false
    
    @Published var errorMessage: String?

    private let getFavoritesUseCase: GetFavoritesUseCaseProtocol
    private let authService: BiometricAuthServiceProtocol

    init(getFavoritesUseCase: GetFavoritesUseCaseProtocol,
         authService: BiometricAuthServiceProtocol = BiometricAuthService()) {
        self.getFavoritesUseCase = getFavoritesUseCase
        self.authService = authService
        loadFavorites()
    }

    func loadFavorites() {
        guard isAuthenticated else { return }
        favorites = getFavoritesUseCase.execute()
    }
    
    func authenticate() {
        authService.authenticate { [weak self] result in
            switch result {
            case .success(let authenticated):
                self?.isAuthenticated = authenticated
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.isAuthenticated = false
            }
        }
    }
}
