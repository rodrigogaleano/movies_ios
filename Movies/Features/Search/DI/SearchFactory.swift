//
//  SearchFactory.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import SwiftUI

enum SearchFactory {
    static func search() -> some View {
        let movieRoutes = MovieRoutes()
        let viewModel = SearchViewModel(SearchMoviesUseCase: SearchMoviesUseCase(movieRoutes: movieRoutes))
        
        return SearchView(viewModel: viewModel)
    }
}
