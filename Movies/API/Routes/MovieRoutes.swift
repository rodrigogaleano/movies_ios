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
    func getMovieCast(id: Int, completion: @escaping Completion)
    func getMovieDetails(id: Int, completion: @escaping Completion)
    func getSimilarMovies(id: Int, completion: @escaping Completion)
    func getSearchedMovies(query: String, completion: @escaping Completion)
}

struct MovieRoutes {
    enum Target: APITarget {
        case movieDetails(id: Int)
        case popularMovies
        case topRatedMovies
        case nowPlayingMovies
        case similarMovies(id: Int)
        case movieCast(id: Int)
        case searchedMovies(query: String)
        
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
            case let .similarMovies(id):
                return "/movie/\(id)/similar"
            case let .movieCast(id):
                return "/movie/\(id)/credits"
            case .searchedMovies:
                return "/search/movie"
            }
        }
        
        var method: Moya.Method { .get }
        
        var task: Task {
            switch self {
            case let .searchedMovies(query):
                return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
            default:
                return .requestPlain
            }
        }
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
    
    func getSimilarMovies(id: Int, completion: @escaping Moya.Completion) {
        provider.request(target: .similarMovies(id: id), completion: completion)
    }
    
    func getMovieCast(id: Int, completion: @escaping Moya.Completion) {
        provider.request(target: .movieCast(id: id), completion: completion)
    }
    
    func getSearchedMovies(query: String, completion: @escaping Moya.Completion) {
        provider.request(target: .searchedMovies(query: query), completion: completion)
    }
}
