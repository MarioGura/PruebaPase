//
//  FilterSection.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import SwiftUI

struct FilterSection: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    private let statuses = ["", "Alive", "Dead", "unknown"]
    private let speciesList = ["", "Human", "Alien", "Humanoid", "Robot", "Mythological Creature", "Animal"]
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack {
                TextField("Buscar por nombre", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            HStack {
                Menu {
                    Picker("Estado", selection: $viewModel.selectedStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status.isEmpty ? "Todos" : status.capitalized).tag(status)
                        }
                    }
                } label: {
                    Label(viewModel.selectedStatus.isEmpty ? "Estado" : viewModel.selectedStatus.capitalized,
                          systemImage: "heart.fill")
                        .padding(8)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
                
                Menu {
                    Picker("Especie", selection: $viewModel.selectedSpecies) {
                        ForEach(speciesList, id: \.self) { species in
                            Text(species.isEmpty ? "Todas" : species.capitalized).tag(species)
                        }
                    }
                } label: {
                    Label(viewModel.selectedSpecies.isEmpty ? "Especie" : viewModel.selectedSpecies.capitalized,
                          systemImage: "pawprint.fill")
                        .padding(8)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
            }
            
            Button {
                Task {
                    await viewModel.loadCharacters(reset: true)
                }
            } label: {
                Text("Aplicar filtros")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}
