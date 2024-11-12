//
//  Movie.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Foundation

struct MovieResult: Decodable {
    var results: [Movie]
}

struct Movie: Decodable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double
    var releaseDate: String
    var runtime: Int?
    var genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case runtime
        case genres
    }
    
    var posterUrl: URL? {
        guard
            let posterPath = posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(posterPath)")
        else { return nil }
        
        return url
    }
    
    var backdropUrl: URL? {
        guard
            let backdropPath = backdropPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(backdropPath)")
        else { return nil }
        
        return url
    }
}

let moviesMock: [Movie] = [
    Movie(
        id: 1,
        title: "Title 1",
        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In malesuada condimentum diam, vel consectetur magna ullamcorper volutpat. Duis mi sapien, ultricies venenatis malesuada ac, maximus eget nisi.",
        posterPath: "https://image.tmdb.org/t/p/w400/gCI2AeMV4IHSewhJkzsur5MEp6R.jpg",
        backdropPath: "https://image.tmdb.org/t/p/w400/gwj4R8Uy1GwejKqfofREKI9Jh7L.jpg",
        voteAverage: 8.456,
        releaseDate: "2024-10-09",
        runtime: 125,
        genres: [
            Genre(id: 1, name: "Horror"),
            Genre(id: 2, name: "Mystery"),
        ]
    ),
    Movie(
        id: 2,
        title: "Title 2",
        overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In malesuada condimentum diam, vel consectetur magna ullamcorper volutpat. Duis mi sapien, ultricies venenatis malesuada ac, maximus eget nisi.",
        posterPath: "https://image.tmdb.org/t/p/w400/gCI2AeMV4IHSewhJkzsur5MEp6R.jpg",
        backdropPath: "https://image.tmdb.org/t/p/w400/gwj4R8Uy1GwejKqfofREKI9Jh7L.jpg",
        voteAverage: 5.239,
        releaseDate: "2024-07-12",
        runtime: 90,
        genres: [
            Genre(id: 1, name: "Comedy"),
            Genre(id: 2, name: "Romance"),
        ]
    ),
]
