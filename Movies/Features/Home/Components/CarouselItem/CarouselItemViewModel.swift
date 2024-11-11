//
//  CarouselItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 06/11/24.
//

import Foundation
 
class CarouselItemViewModel: CarouselItemProtocol {
    // MARK: - Init
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    // MARK: - Public Getters
    
    var movieId: Int {
        movie.id
    }
    
    var imageUrl: URL? {
        movie.backdropUrl
    }
    
    var movieTitle: String {
        movie.title
    }
}
