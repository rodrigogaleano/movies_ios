//
//  MovieDetailsFactory.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/11/24.
//

import SwiftUI

enum MovieDetailsFactory {
    static func MovieDetails(movieId: Int) -> some View {
        let repository = MoviesRepository(routes: MovieRoutes())
        let viewModel = MovieDetailsViewModel(movieId: movieId, repository: repository)
        
        return MovieDetailsView(viewModel: viewModel)
    }
}
