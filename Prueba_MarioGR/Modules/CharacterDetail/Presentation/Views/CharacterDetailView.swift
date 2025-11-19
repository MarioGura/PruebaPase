//
//  CharacterDetailView.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import SwiftUI
import MapKit

struct CharacterDetailView: View {
    @StateObject private var viewModel: CharacterDetailViewModel
    let characterId: Int
    @State private var showInfo = false
    @State private var selectedCoordinate: CLLocationCoordinate2D? = nil
    
    private let pinDownOffset: CGFloat = 40
    private let labelUpOffset: CGFloat = -10
    private let labelOpacityVisible: Double = 1.0
    private let labelOpacityHidden: Double = 0.0
    
    init(characterId: Int, viewModel: CharacterDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.characterId = characterId
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Cargando detalle...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let detail = viewModel.detail {
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: detail.image)) { image in
                            switch image {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            case .failure:
                                Color.gray
                                    .frame(width: 300, height: 300)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 4)
                        .overlay(alignment: .topTrailing) {
                            favoriteButton
                                .padding()
                        }
                        
                        Text(detail.name ?? "Detalle")
                            .font(.largeTitle.bold())
                            .padding(.top, 8)
                            .accessibilityIdentifier("CharacterDetailTitle")
                        
                        VStack(alignment: .leading, spacing: 8) {
                            infoRow(label: "🚻 Gender:", value: detail.gender)
                            infoRow(label: "👽 Species:", value: detail.species)
                            infoRow(label: "🧬 Status:", value: detail.status)
                            HStack {
                                infoRow(label: "📍 Location:", value: detail.location.name)
                                Spacer()
                                Button(viewModel.showLocation ? "Ocultar ubicación" : "Ver ubicación") {
                                    withAnimation {
                                        viewModel.toggleLocationVisibility()
                                    }
                                }
                                .font(.footnote.bold())
                                .foregroundColor(.blue)
                            }
                            
                            if viewModel.showLocation, let coordinate = viewModel.coordinate {
                                ZStack {
                                    Map(
                                        coordinateRegion: .constant(
                                            MKCoordinateRegion(
                                                center: coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                                            )
                                        ),
                                        annotationItems: [PinItem(coordinate: coordinate)]
                                    ) { item in
                                        MapAnnotation(coordinate: item.coordinate) {
                                            ZStack {
                                                VStack(spacing: 4) {
                                                    Text("Última ubicación").bold().font(.caption)
                                                    Text("Lat: \(item.coordinate.latitude, specifier: "%.4f")").font(.caption2)
                                                    Text("Lng: \(item.coordinate.longitude, specifier: "%.4f")").font(.caption2)
                                                }
                                                .padding(8)
                                                .background(Color.white)
                                                .cornerRadius(8)
                                                .shadow(radius: 4)
                                                .offset(y: showInfo ? labelUpOffset : (labelUpOffset - 30))
                                                .opacity(showInfo ? labelOpacityVisible : labelOpacityHidden)
                                                .animation(.spring(), value: showInfo)
                                                
                                                Image(systemName: "mappin.circle.fill")
                                                    .font(.title)
                                                    .foregroundColor(.red)
                                                    .offset(y: showInfo ? pinDownOffset : 0)
                                                    .onTapGesture {
                                                        withAnimation(.spring()) {
                                                            selectedCoordinate = item.coordinate
                                                            showInfo.toggle()
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                    
                                    if showInfo {
                                        Color.black.opacity(0.001)
                                            .ignoresSafeArea()
                                            .onTapGesture {
                                                withAnimation(.spring()) {
                                                    showInfo = false
                                                }
                                            }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("🎬 Episodios:")
                                        .bold()
                                    Spacer()
                                    Text("Visto")
                                }
                                ForEach(detail.episode, id: \.self) { url in
                                    HStack {
                                        Text(url)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Button(action: {
                                            viewModel.toggleEpisodeSeen(url)
                                        }) {
                                            Image(systemName: viewModel.isEpisodeSeen(url) ? "checkmark.circle.fill" : "checkmark.circle")
                                                .foregroundColor(viewModel.isEpisodeSeen(url) ? .green : .gray)
                                                .imageScale(.large)
                                        }
                                        .accessibilityIdentifier("EpisodeButton_\(url)")
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding(.top, 8)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 8) {
                    Text("Error 😞")
                        .font(.headline)
                    Text(error)
                        .multilineTextAlignment(.center)
                    Button("Reintentar") {
                        Task { await viewModel.fetchDetail(id: characterId) }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("Sin información disponible.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if viewModel.detail == nil {
                await viewModel.fetchDetail(id: characterId)
            }
        }
    }
    
    private var favoriteButton: some View {
        Button {
            withAnimation(.spring()) {
                viewModel.toggleFavorite()
            }
        } label: {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(viewModel.isFavorite ? .red : .red)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(radius: 2)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("FavoritoButton")
    }
    
    // MARK: - Helpers
    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label).bold()
            Text(value)
        }
    }
    
    private func formattedDate(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return dateString
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mockUseCase = MockGetCharacterDetailUseCase()
        let mockFavorites = FavoritesRepositoryMock()
        let mockSeen = MockSeenEpisodesRepository()
        
        mockUseCase.mockDetail = CharacterDetailModel(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: .init(name: "Earth", url: ""),
            location: .init(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/16.jpeg",
            episode: [],
            url: "",
            created: ""
        )
        
        let viewModel = CharacterDetailViewModel(
            getCharacterDetailUseCase: mockUseCase,
            favoritesRepo: mockFavorites,
            seenRepo: mockSeen
        )
        
        viewModel.detail = mockUseCase.mockDetail
        
        return CharacterDetailView(characterId: 2, viewModel: viewModel)
    }
}



