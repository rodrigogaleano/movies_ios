//
//  MovieRoutes.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya

protocol MovieRoutesProtocol {
    func getPopularMovies(completion: @escaping Completion)
    func getTopRatedMovies(completion: @escaping Completion)
    func getNowPlayingMovies(completion: @escaping Completion)
    func getMovieDetails(id: Int, completion: @escaping Completion)
}

struct MovieRoutes {
    enum Target: APITarget {
        case movieDetails(id: Int)
        case popularMovies
        case topRatedMovies
        case nowPlayingMovies
        
        var path: String {
            switch self {
            case .nowPlayingMovies:
                return "/movie/now_playing"
            case .popularMovies:
                return "/movie/popular"
            case .topRatedMovies:
                return "/movie/top_rated"
            case let .movieDetails(id):
                return "/movie/\(id)"
            }
        }
        
        var method: Moya.Method { .get }
        
        var task: Moya.Task { .requestPlain }
    }
    
    private let provider = APIProvider<Target>()
}

extension MovieRoutes: MovieRoutesProtocol {
    func getNowPlayingMovies(completion: @escaping Completion) {
        provider.request(target: .nowPlayingMovies, completion: completion)
    }
    
    func getPopularMovies(completion: @escaping Moya.Completion) {
        provider.request(target: .popularMovies, completion: completion)
    }
    
    func getTopRatedMovies(completion: @escaping Completion) {
        provider.request(target: .topRatedMovies, completion: completion)
    }
    
    func getMovieDetails(id: Int, completion: @escaping Moya.Completion) {
        provider.request(target: .movieDetails(id: id), completion: completion)
    }
}
