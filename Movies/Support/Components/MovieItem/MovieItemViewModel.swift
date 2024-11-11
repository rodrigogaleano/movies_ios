//
//  MovieItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Foundation


class MovieItemViewModel: MovieItemViewModelProtocol {
    
    // MARK: - Private Properties
    
    private var movie: Movie
    
    // MARK: - Init

    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Public Getters
    
    var title: String {
        movie.title
    }
    
    var imageUrl: URL? {
        movie.posterUrl
    }
    
    var movieId: Int {
        movie.id
    }
}
