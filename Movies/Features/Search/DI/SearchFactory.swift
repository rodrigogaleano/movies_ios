//
//  SearchFactory.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import SwiftUI

enum SearchFactory {
    static func search() -> some View {
        let viewModel = SearchViewModel(moviesRepository: MoviesRepository(routes: MovieRoutes()))
        
        return SearchView(viewModel: viewModel)
    }
}
