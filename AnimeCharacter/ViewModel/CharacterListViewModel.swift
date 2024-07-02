//
//  CharacterListViewModel.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var isLoading = false
    @Published var hasMorePages = false
    @Published var query = ""

    @Published var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    private var totalPageCount = 0

    func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true
        NetworkManager.shared.fetch(AnimeAPI.characterList(page: currentPage), type: CharacterResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                }
            }, receiveValue: { [weak self] response in
                self?.characters.append(contentsOf: response.results)
                self?.totalPageCount = response.info.pages
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
            guard !isLoading, currentPage < totalPageCount else { return }
            currentPage += 1
            fetchCharacters()
        }
    
    func refresh() {
        currentPage = 1
        characters.removeAll()
        fetchCharacters()
    }
    
    func logout() {
        // Logic to handle logout
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPassword")
    }
    
    func shouldLoadNextPage(character: Character) -> Bool {
        guard let lastCharacter = characters.last else { return false }
        return character.id == lastCharacter.id
    }
}

