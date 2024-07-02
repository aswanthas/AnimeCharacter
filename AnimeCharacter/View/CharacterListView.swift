//
//  CharacterListView.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel = CharacterListViewModel()
    @State private var selectedCharacter: Character?
    @State private var isNaviagteToDetail: Bool = false
    
    var coloums: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Repositories", text: $viewModel.query, onCommit: {
                    viewModel.currentPage = 1 // Need to do the search flow
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                ScrollView {
                    LazyVGrid(columns: coloums, spacing: 32) {
                        ForEach(viewModel.characters) { character in
                            CharacterCell(character: character)
                                .frame(height: 200)
                                .onTapGesture {
                                    self.selectedCharacter = character
                                    self.isNaviagteToDetail = true
                                }
                                .onAppear {
                                    if character.id == self.viewModel.characters.last?.id {
                                        self.viewModel.loadNextPage()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }

                    if let characters = selectedCharacter {
                        NavigationLink(
                            destination: CharacterDetailsView(character: characters),
                            isActive: self.$isNaviagteToDetail
                        ) {
                            EmptyView()
                        }
                        .hidden() // Hide the NavigationLink
                    }
                }
                .background(Color.white)
                .refreshable {
                    ProgressView()
                    viewModel.refresh()
                }
            }
            .navigationBarTitle("Home")
            .onAppear {
                self.viewModel.fetchCharacters()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CharacterListView()
}
