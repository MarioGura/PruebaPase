//
//  CharacterRow.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

import SwiftUI

struct CharacterRow: View {
    let character: CharacterModel
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    switch image {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    case .failure:
                        Color.gray
                            .cornerRadius(24)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    Text("\(character.species)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(character.status)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.vertical, 4)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CharacterRow(
        character: CharacterModel(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        )
    )
}
