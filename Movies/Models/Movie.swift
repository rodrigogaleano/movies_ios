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
    var posterPath: String
    var backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    var posterUrl: URL? {
        guard
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(posterPath)")
        else { return nil }
        
        return url
    }
    
    var backdropUrl: URL? {
        guard
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(backdropPath)")
        else { return nil }
        
        return url
    }
}
