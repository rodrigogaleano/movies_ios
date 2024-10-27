//
//  MoviesRepository.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya
import Foundation

typealias Success = (([Movie]) -> Void)
typealias Failure = ((String) -> Void)

protocol MoviesRepositoryProtocol {
    func fetchNowPlayingMovies(success: Success?, failure: Failure?)
}

class MoviesRepository: MoviesRepositoryProtocol {
    
    // MARK: - Private Properties
    
    private let routes: MovieRoutesProtocol
    
    // MARK: - Init
    
    init(routes: MovieRoutesProtocol) {
        self.routes = routes
    }
    
    func fetchNowPlayingMovies(success: Success?, failure: Failure?) {
        routes.getNowPlayingMovies { result in
            switch result {
            case let .success(response):
                do {
                    let results = try response.map(MovieResult.self)
                    let movies = results.results
                    
                    success?(movies)
                } catch {
                    failure?("Error decoding data.")
                }
            case let .failure(error):
                failure?(error.localizedDescription)
            }
        }
    }
}

