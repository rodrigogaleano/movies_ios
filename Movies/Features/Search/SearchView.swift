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
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Group{
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
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.searchMoviesViewModels.indices, id: \.self) { index in
                                let currentViewModel = viewModel.searchMoviesViewModels[index]
                                
                                SearchedMovieItemView(viewModel: currentViewModel)
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Search")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(text: Binding(
                get: { viewModel.searchText },
                set: { viewModel.searchText = $0 }
            ))
        }
    }
}

#Preview {
    SearchFactory.search()
}
