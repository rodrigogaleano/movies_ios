//
//  SearchMoviesUseCase.swift
//  Movies
//
//  Created by Rodrigo Galeano on 25/11/24.
//

protocol SearchMoviesUseCaseProtocol {
    typealias Success = ([Movie]) -> Void
    typealias Failure = (String) -> Void
    
    func execute(query: String, success: Success?, failure: Failure?)
}

class SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    private let movieRoutes: MovieRoutesProtocol
    
    init(movieRoutes: MovieRoutesProtocol) {
        self.movieRoutes = movieRoutes
    }
    
    func execute(query: String, success: Success?, failure: Failure?) {
        movieRoutes.getSearchedMovies(query: query) { result in
            switch (result) {
            case .success(let response):
                do {
                    let movieResult = try response.map(MovieResult.self)
                    
                    success?(movieResult.results)
                } catch {
                    failure?("Error decoding data")
                }
            case .failure(let error):
                failure?(error.localizedDescription)
            }
        }
    }
}
