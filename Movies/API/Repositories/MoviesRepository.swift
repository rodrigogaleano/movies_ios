//
//  MoviesRepository.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya
import Foundation

typealias Success = (([Movie]) -> Void)
typealias MovieSuccess = ((Movie) -> Void)
typealias CastMemberSuccess = (([CastMember]) -> Void)
typealias Failure = ((String) -> Void)

protocol MoviesRepositoryProtocol {
    func fetchPopularMovies(success: Success?, failure: Failure?)
    func fetchTopRatedMovies(success: Success?, failure: Failure?)
    func fetchNowPlayingMovies(success: Success?, failure: Failure?)
    func fetchMovieDetails(id: Int, success: MovieSuccess?, failure: Failure?)
    func fetchSimilarMovies(id: Int, success: Success?, failure: Failure?)
    func fetchCastMembers(id: Int, success: CastMemberSuccess?, failure: Failure?)
}

class MoviesRepository {
    // MARK: - Private Properties
    
    private let routes: MovieRoutesProtocol
    
    // MARK: - Init
    
    init(routes: MovieRoutesProtocol) {
        self.routes = routes
    }
    
}

extension MoviesRepository: MoviesRepositoryProtocol {
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
    
    func fetchPopularMovies(success: Success?, failure: Failure?) {
        routes.getPopularMovies { result in
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
    
    func fetchTopRatedMovies(success: Success?, failure: Failure?) {
        routes.getTopRatedMovies { result in
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
    
    func fetchMovieDetails(id: Int, success: MovieSuccess?, failure: Failure?) {
        routes.getMovieDetails(id: id) { result in
            switch result {
            case let .success(response):
                do {
                    let movie = try response.map(Movie.self)
                    success?(movie)
                } catch {
                    failure?("Error decoding data.")
                }
            case let .failure(error):
                failure?(error.localizedDescription)
            }
        }
    }
    
    func fetchSimilarMovies(id: Int, success: Success?, failure: Failure?) {
        routes.getSimilarMovies(id: id) { result in
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
    
    func fetchCastMembers(id: Int, success: CastMemberSuccess?, failure: Failure?) {
        routes.getMovieCast(id: id) { result in
            switch result {
            case let .success(response):
                do {
                    let castMembers = try response.map(CastMemberResult.self)
                    
                    success?(castMembers.cast)
                } catch {
                    failure?("Error decoding data.")
                }
            case let .failure(error):
                failure?(error.localizedDescription)
            }
        }
    }
}
