//
//  GetMoviesDetailsUseCase.swift
//  Movies
//
//  Created by Rodrigo Galeano on 25/11/24.
//

protocol GetMovieDetailsUseCaseProtocol {
    typealias Success = (Movie) -> Void
    typealias Failure = (String) -> Void
    
    func execute(movieId: Int, success: Success?, failure: Failure?)
}

class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {
    private let movieRoutes: MovieRoutesProtocol
    
    init(movieRoutes: MovieRoutesProtocol) {
        self.movieRoutes = movieRoutes
    }
    
    func execute(movieId: Int, success: Success?, failure: Failure?) {
        movieRoutes.getMovieDetails(id: movieId) { result in
            switch (result) {
            case .success(let response):
                do {
                    let movie = try response.map(Movie.self)
                    
                    success?(movie)
                } catch {
                    failure?("Error decoding data")
                }
            case .failure(let error):
                failure?(error.localizedDescription)
            }
        }
    }
}
