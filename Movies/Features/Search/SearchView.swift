//
//  SearchView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import SwiftUI

protocol SearchViewProtocol: ObservableObject {
    var isLoading: Bool { get }
    var errorMessage: String { get }
    var searchText: String { get set }
    var searchMoviesViewModels: [SearchedMovieItemProtocol] { get }
}

struct SearchView<ViewModel: SearchViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Search for a movie", text: Binding(
                    get: { viewModel.searchText },
                    set: { viewModel.searchText = $0 }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top)
                if viewModel.isLoading {
                    LoadingView()
                }
                else if viewModel.searchText.isEmpty {
                    InstructionView()
                }
                else if !viewModel.errorMessage.isEmpty { ErrorView(errorMessage: viewModel.errorMessage) }
                else if viewModel.searchMoviesViewModels.isEmpty {
                    NoResultsView()
                }
                else {
                    ScrollView {
                        ForEach(viewModel.searchMoviesViewModels.indices, id: \.self) { index in
                            let currentViewModel = viewModel.searchMoviesViewModels[index]
                            
                            SearchedMovieItemView(viewModel: currentViewModel)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Search")
            .toolbarTitleDisplayMode(.inlineLarge)
            .edgesIgnoringSafeArea(.bottom) 
        }
    }
}

#Preview {
    SearchFactory.search()
}
