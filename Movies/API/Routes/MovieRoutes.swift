//
//  MovieRoutes.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya

protocol MovieRoutesProtocol {
    func getNowPlayingMovies(completion: @escaping Completion)
    func getPopularMovies(completion: @escaping Completion)
    func getTopRatedMovies(completion: @escaping Completion)
}

struct MovieRoutes {
    enum Target: APITarget {
        case nowPlayingMovies
        case popularMovies
        case topRatedMovies
        
        var path: String {
            switch self {
            case .nowPlayingMovies:
                return "/movie/now_playing"
            case .popularMovies:
                return "/movie/popular"
            case .topRatedMovies:
                return "/movie/top_rated"
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
}
