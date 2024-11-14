//
//  SearchView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import SwiftUI

protocol SearchViewProtocol: ObservableObject {
    var searchText: String { get set }
    var searchMoviesViewModels: [SearchedMovieItemProtocol] { get }
}

struct SearchView<ViewModel: SearchViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search for a movie", text: Binding(
                get: { viewModel.searchText },
                set: { viewModel.searchText = $0 }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            ScrollView {
                ForEach(viewModel.searchMoviesViewModels.indices, id: \.self) { index in
                    let currentViewModel = viewModel.searchMoviesViewModels[index]
                    
                    SearchedMovieItemView(viewModel: currentViewModel)
                }
            }
        }
    }
}

#Preview {
    SearchFactory.search()
}
