//
//  SearchedMovieItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 14/11/24.
//

import Foundation

class SearchedMovieItemViewModel {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension SearchedMovieItemViewModel: SearchedMovieItemProtocol {
    var movieId: Int {
        movie.id
    }
    
    var imageUrl: URL? {
        movie.posterUrl
    }
    
    var movieTitle: String {
        movie.title
    }
    
    var overview: String {
        movie.overview
    }
}
