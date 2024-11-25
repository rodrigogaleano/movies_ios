//
//  GetSimilarMoviesUseCase.swift
//  Movies
//
//  Created by Rodrigo Galeano on 25/11/24.
//

protocol GetSimilarMoviesUseCaseProtocol {
    typealias Success = ([Movie]) -> Void
    typealias Failure = (String) -> Void
    
    func execute(movieId: Int, success: Success?, failure: Failure?)
}

class GetSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol {
    private let movieRoutes: MovieRoutesProtocol
    
    init(movieRoutes: MovieRoutesProtocol) {
        self.movieRoutes = movieRoutes
    }
    
    func execute(movieId: Int, success: Success?, failure: Failure?) {
        movieRoutes.getSimilarMovies(id: movieId) { result in
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
