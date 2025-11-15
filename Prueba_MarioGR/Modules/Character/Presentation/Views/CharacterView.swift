//
//  MainView.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var viewModel: CharacterViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FilterSection(viewModel: viewModel)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                
                Group {
                    switch viewModel.state {
                    case .idle, .loaded:
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.characters) { character in
                                    CharacterRow(character: character) {
                                        viewModel.idCharacter = character.id
                                        viewModel.isSelectCharacter = true
                                    }
                                    .accessibilityElement(children: .contain)
                                    .accessibilityIdentifier("CharacterRow_\(character.id)")
                                    .onAppear {
                                        Task {
                                            await viewModel.loadNextIfNeeded(currentItem: character)
                                        }
                                    }
                                }
                                
                                if viewModel.canLoadMore {
                                    ProgressView()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                            }
                        }
                        .refreshable {
                            await viewModel.resetFiltersAndReload()
                        }
                        
                    case .loading:
                        ProgressView("Cargando...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    case .empty:
                        VStack {
                            Text("Sin resultados")
                                .font(.headline)
                            Text("Prueba con otros filtros o limpia la búsqueda.")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    case .error(let message):
                        VStack {
                            Text("Error 😞")
                                .font(.headline)
                            Text(message)
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Reintentar") {
                                Task { await viewModel.loadCharacters(reset: true) }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .navigationTitle("Personajes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showFavorites.toggle()
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("Favoritos")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
                    .accessibilityIdentifier("BotonFavoritos")
                }
            }
            .navigationDestination(isPresented: $viewModel.isSelectCharacter) {
                let id = viewModel.idCharacter
                if let detailVM = AppContainer.shared.container.resolve(CharacterDetailViewModel.self) {
                    CharacterDetailView(characterId: id, viewModel: detailVM)
                } else {
                    Text("No se pudo cargar el detalle del personaje 😞")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .navigationDestination(isPresented: $viewModel.showFavorites) {
                if let favoriteVM = AppContainer.shared.container.resolve(FavoritesViewModel.self) {
                    FavoritesView(viewModel: favoriteVM)
                } else {
                    Text("No se pudo cargar la vista de favoritos 😞")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                Task {
                    if viewModel.state == .idle {
                        await viewModel.loadCharacters(reset: true)
                    }
                }
            }
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppContainer.shared.container.resolve(CharacterViewModel.self)!
        CharacterView(viewModel: viewModel)
            .previewDisplayName("Vista real con dependencias")
    }
}
