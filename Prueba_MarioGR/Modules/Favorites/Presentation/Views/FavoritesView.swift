//
//  FavoritesView.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                // Contenido de favoritos
                List(viewModel.favorites) { favorite in
                    HStack {
                        AsyncImage(url: URL(string: favorite.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        
                        Text(favorite.name)
                            .font(.headline)
                    }
                }
                .task {
                    if viewModel.isAuthenticated {
                        await viewModel.loadFavorites()
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Text("Autenticación requerida 🔒")
                        .font(.headline)
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    Button("Autenticar") {
                        viewModel.authenticate()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
            }
        }
        .navigationTitle("Favoritos")
        .accessibilityIdentifier("FavoritesView")
        .onAppear {
            viewModel.authenticate()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {

        let mockFavorites = [
            CharacterModel(id: 1,
                           name: "Rick Sanchez",
                           status: "Alive",
                           species: "Human",
                           image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            CharacterModel(id: 2,
                           name: "Morty Smith",
                           status: "Alive",
                           species: "Human",
                           image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
        ]

        let mockUseCase = MockGetFavoritesUseCase()
        let mockAuth = MockBiometricAuthService()

        let viewModel = FavoritesViewModel(
            getFavoritesUseCase: mockUseCase,
            authService: mockAuth
        )

        viewModel.isAuthenticated = true
        viewModel.loadFavorites()

        return FavoritesView(viewModel: viewModel)
    }
}

