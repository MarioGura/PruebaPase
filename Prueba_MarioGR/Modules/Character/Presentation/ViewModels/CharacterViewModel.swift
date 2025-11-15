//
//  CharacterViewModel.swift
//  prueba_Pase_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//


import Foundation

final class CharacterViewModel: ObservableObject {
    
    @Published var characters: [CharacterModel] = []
    @Published var state: ViewState = .idle
    @Published var isSelectCharacter: Bool = false
    @Published var showFavorites: Bool = false
    
    @Published var searchText: String = ""
    @Published var selectedStatus: String = ""
    @Published var selectedSpecies: String = ""
    
    private var currentPage: Int = 1
    private var canFetchMore: Bool = true
    var idCharacter: Int = -1
    
    private let getCharactersUseCase: GetCharactersUseCaseProtocol
    
    // MARK: - Init
    init(getCharactersUseCase: GetCharactersUseCaseProtocol) {
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    var canLoadMore: Bool {
        canFetchMore && state == .loaded
    }
    
    @MainActor
    func loadCharacters(reset: Bool = false) async {
        if reset {
            currentPage = 1
            characters.removeAll()
            canFetchMore = true
        }
        
        state = .loading
        
        do {
            let result = try await getCharactersUseCase.execute(
                page: currentPage,
                name: searchText,
                status: selectedStatus,
                species: selectedSpecies
            )

            guard !result.isEmpty else {
                state = .empty
                return
            }

            if currentPage == 1 {
                characters = result
            } else {
                characters.append(contentsOf: result)
            }

            canFetchMore = !result.isEmpty

            state = .loaded
            
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    func loadNextIfNeeded(currentItem: CharacterModel) async {
        guard let last = characters.last,
              last.id == currentItem.id,
              canFetchMore,
              state == .loaded else { return }
        
        currentPage += 1
        await loadCharacters()
    }
    
    @MainActor
    func resetFiltersAndReload() async {
        searchText = ""
        selectedStatus = ""
        selectedSpecies = ""
        await loadCharacters(reset: true)
    }
}
