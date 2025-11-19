//
//  CharacterDetailViewMode.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
import MapKit

final class CharacterDetailViewModel: ObservableObject {
    @Published var detail: CharacterDetailModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isFavorite: Bool = false
    @Published var isWatched: Bool = false
    @Published var showLocation: Bool = false
    @Published var seenEpisodes: Set<String> = []
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    private let getCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol
    private let favoritesRepo: FavoritesRepositoryProtocol
    private let seenRepo: SeenEpisodesRepositoryProtocol
    
    init(getCharacterDetailUseCase: GetCharacterDetailUseCaseProtocol,
         favoritesRepo: FavoritesRepositoryProtocol,
         seenRepo: SeenEpisodesRepositoryProtocol) {
        self.getCharacterDetailUseCase = getCharacterDetailUseCase
        self.favoritesRepo = favoritesRepo
        self.seenRepo = seenRepo
    }
    
    @MainActor
    func fetchDetail(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await getCharacterDetailUseCase.execute(id: id)
            detail = result
            self.coordinate = randomCoordinates(for: result.id)
            loadFavoriteStatus(for: Int64(result.id))
            self.loadSeenEpisodes()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func toggleFavorite() {
        guard let character = detail else { return }
        do {
            if isFavorite {
                try favoritesRepo.removeFavorite(id: Int64(character.id))
            } else {
                try favoritesRepo.addFavorite(character: character)
            }
            isFavorite.toggle()
        } catch {
            print("Error toggling favorite: \(error)")
        }
    }
    
    @MainActor
    func toggleLocationVisibility() {
        showLocation.toggle()
    }
    
    func toggleEpisodeSeen(_ urlString: String) {
        do {
            if seenEpisodes.contains(urlString) {
                try seenRepo.unmarkSeen(urlString: urlString)
                seenEpisodes.remove(urlString)
            } else {
                try seenRepo.markSeen(urlString: urlString)
                seenEpisodes.insert(urlString)
            }
        } catch {
            print("Error toggling seen episode: \(error)")
        }
    }

    func isEpisodeSeen(_ episode: String) -> Bool {
        seenEpisodes.contains(episode)
    }
    
    func loadSeenEpisodes() {
        let episodes = seenRepo.fetchSeenEpisodes()
        self.seenEpisodes = Set(episodes.map { $0.urlString })
    }
    
    func loadFavoriteStatus(for characterId: Int64) {
        isFavorite = favoritesRepo.isFavorite(id: characterId)
    }
}

extension CharacterDetailViewModel {
    func randomCoordinates(for id: Int) -> CLLocationCoordinate2D {
        return randomCoordinate(for: id)
    }
}

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}


