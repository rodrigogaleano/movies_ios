//
//  MovieRoutes.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import Moya

protocol MovieRoutesProtocol {
    func getNowPlayingMovies(completion: @escaping Completion)
}

struct MovieRoutes {
    enum Target: APITarget {
        case nowPlayingMovies
        
        var path: String {
            switch self {
            case .nowPlayingMovies:
                return "/movie/now_playing"
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
}
