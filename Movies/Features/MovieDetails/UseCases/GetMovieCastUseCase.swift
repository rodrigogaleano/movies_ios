//
//  GetMovieCastUseCase.swift
//  Movies
//
//  Created by Rodrigo Galeano on 25/11/24.
//

protocol GetMovieCastUseCaseProtocol {
    typealias Success = ([CastMember]) -> Void
    typealias Failure = (String) -> Void
    
    func execute(movieId: Int, success: Success?, failure: Failure?)
}

class GetMovieCastUseCase: GetMovieCastUseCaseProtocol {
    private let movieRoutes: MovieRoutesProtocol
    
    init(movieRoutes: MovieRoutesProtocol) {
        self.movieRoutes = movieRoutes
    }
    
    func execute(movieId: Int, success: Success?, failure: Failure?) {
        movieRoutes.getMovieCast(id: movieId) { result in
            switch (result) {
            case .success(let response):
                do {
                    let castMembers = try response.map(CastMemberResult.self)
                    
                    success?(castMembers.cast)
                } catch {
                    failure?("Error decoding data")
                }
            case .failure(let error):
                failure?(error.localizedDescription)
            }
        }
    }
}
