//
//  MovieDetailsFactory.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/11/24.
//

import SwiftUI

enum MovieDetailsFactory {
    static func MovieDetails(movieId: Int) -> some View {
        let movieRoutes = MovieRoutes()
        let viewModel = MovieDetailsViewModel(
            movieId: movieId,
            getMovieCastUseCase: GetMovieCastUseCase(movieRoutes: movieRoutes),
            getMovieDetailsUseCase: GetMovieDetailsUseCase(movieRoutes: movieRoutes),
            getSimilarMoviesUseCase: GetSimilarMoviesUseCase(movieRoutes: movieRoutes)
        )
        
        return MovieDetailsView(viewModel: viewModel)
    }
}
