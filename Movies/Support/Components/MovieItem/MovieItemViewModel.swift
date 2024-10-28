//
//  MovieItemViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Foundation

class MovieItemViewModel: ObservableObject, MovieItemProtocol {
    @Published var title: String
    @Published var imageUrl: URL?

    init(movie: Movie) {
        self.title = movie.title
        self.imageUrl = movie.imageUrl
    }
}
