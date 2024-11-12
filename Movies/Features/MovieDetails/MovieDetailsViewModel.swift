//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 07/11/24.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var similarMovies: [Movie] = []
    @Published var castMembers: [CastMember] = []
    
    let movieId: Int
    let repository: MoviesRepositoryProtocol
    
    init(movieId: Int, repository: MoviesRepositoryProtocol) {
        self.movieId = movieId
        self.repository = repository
    }
}

extension MovieDetailsViewModel: MovieDetailViewModelProtocol {
    var title: String {
        movie?.title ?? ""
    }
    
    var overview: String {
        movie?.overview ?? ""
    }
    
    var releaseYear: String {
        if let releaseYear = movie?.releaseDate.split(separator: "-").first {
            return String(releaseYear)
        }
        
        return ""
    }
    
    var runtime: String {
        guard let runtime = movie?.runtime else { return "" }
        
        let hours = runtime / 60
        let minutes = runtime % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        
        return "\(minutes)m"
    }
    
    var voteAverage: String {
        String(format: "%.1f", movie?.voteAverage ?? 0)
    }
    
    var backdropURL: URL? {
        movie?.backdropUrl
    }
    
    var genre: String {
        movie?.genres?.first?.name ?? ""
    }
    
    var similarMoviesViewModels: [any MovieItemViewModelProtocol] {
        similarMovies.map { MovieItemViewModel(movie: $0) }
    }
    
    var castMembersImageURLs: [URL] {
        castMembers.compactMap { $0.profileImageURL }
    }

    func loadContent() {
        loadMovieDetails()
        loadMovieCast()
        loadSimilarMovies()
    }
}

extension MovieDetailsViewModel {
    private func loadMovieDetails() {
        repository.fetchMovieDetails(id: movieId) { movie in
            self.movie = movie
        } failure: { error in
            // TODO: Tratar o erro
        }
    }
    
    private func loadMovieCast() {
        repository.fetchCastMembers(id: movieId) { castMember in
            self.castMembers = castMember
        } failure: { error in
            // TODO: Tratar o erro
        }
    }
    
    private func loadSimilarMovies() {
        repository.fetchSimilarMovies(
            id: movieId,
            success: { similarMovies in
                self.similarMovies = similarMovies
            }, failure: { error in
                // TODO: Tratar erro
            }
        )
    }
}
