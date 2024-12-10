//
//  MovieDetails.swift
//  Movies
//
//  Created by Rodrigo Galeano on 10/12/24.
//

import Foundation

struct MovieDetails: Decodable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var backdropPath: String?
    var voteAverage: Double
    var releaseDate: String
    var runtime: Int?
    var genres: [Genre]?
    var originCountry: [String]?
    var originalLanguage: String?
    var productionCompanies: [ProductionCompany]?
    
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
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case productionCompanies = "production_companies"
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
