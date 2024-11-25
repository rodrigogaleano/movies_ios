//
//  CarouselItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 06/11/24.
//

import Foundation

class CarouselItemViewModel {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension CarouselItemViewModel: CarouselItemProtocol {
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
