//
//  GetMovieCreditsUseCase.swift
//  Movies
//
//  Created by Rodrigo Galeano on 25/11/24.
//

protocol GetMovieCreditsUseCaseProtocol {
    typealias Success = (Credits) -> Void
    typealias Failure = (String) -> Void
    
    func execute(movieId: Int, success: Success?, failure: Failure?)
}

class GetMovieCreditsUseCase: GetMovieCreditsUseCaseProtocol {
    private let movieRoutes: MovieRoutesProtocol
    
    init(movieRoutes: MovieRoutesProtocol) {
        self.movieRoutes = movieRoutes
    }
    
    func execute(movieId: Int, success: Success?, failure: Failure?) {
        movieRoutes.getMovieCast(id: movieId) { result in
            switch (result) {
            case .success(let response):
                do {
                    let credits = try response.map(Credits.self)
                    
                    success?(credits)
                } catch {
                    failure?("Error decoding data")
                }
            case .failure(let error):
                failure?(error.localizedDescription)
            }
        }
    }
}
