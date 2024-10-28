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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
    
    var imageUrl: URL? {
        guard
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        else { return nil }
        
        return url
    }
}
