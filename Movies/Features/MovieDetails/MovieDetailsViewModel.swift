//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 07/11/24.
//

import Foundation

class MovieDetailsViewModel {
    @Published private var isCreditsLoading: Bool = true
    @Published private var isMovieDetailsLoading: Bool = true
    @Published private var isSimilarMoviesLoading: Bool = true
    @Published var error: String = ""
    @Published var movie: Movie?
    @Published var similarMovies: [Movie] = []
    @Published var castMembers: [CastMember] = []
    @Published var crewMembers: [CrewMember] = []
    
    private let movieId: Int
    private let getMovieCastUseCase: GetMovieCreditsUseCaseProtocol
    private let getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol
    
    init(
        movieId: Int,
        getMovieCastUseCase: GetMovieCreditsUseCaseProtocol,
        getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol,
        getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol
    ) {
        self.movieId = movieId
        self.getMovieCastUseCase = getMovieCastUseCase
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }
}

extension MovieDetailsViewModel: MovieDetailViewModelProtocol {
    var director: String {
        crewMembers.first(where: { $0.job == "Director" })?.name ?? ""
    }
    
    var errorMessage: String {
        self.error
    }
    
    var isLoading: Bool {
        isCreditsLoading || isMovieDetailsLoading || isSimilarMoviesLoading
    }
    
    var title: String {
        movie?.title ?? ""
    }
    
    var overview: String {
        movie?.overview ?? ""
    }
    
    var releaseYear: String {
        movie?.releaseDate.split(separator: "-").first.map { String($0) } ?? ""
    }
    
    var runtime: String {
        guard let runtime = movie?.runtime else { return "" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
    }
    
    var voteAverage: String {
        String(format: "%.1f", movie?.voteAverage ?? 0)
    }
    
    var posterURL: URL? {
        movie?.posterUrl
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
    
    var castMembersViewModels: [any CastMemberItemViewModelProtocol] {
        castMembers.map { CastMemberItemViewModel(castMember: $0)}
    }
   
    var crewMembersViewModels: [any CrewMemberItemViewModelProtocol] {
        crewMembers.map { CrewMemberItemViewModel(crewMember: $0)}
    }
    
    var genres: [String] {
        movie?.genres?.map { $0.name } ?? []
    }
    
    func loadContent() {
        loadMovieDetails()
        loadMovieCast()
        loadSimilarMovies()
    }
}

private extension MovieDetailsViewModel {
    func loadMovieDetails() {
        getMovieDetailsUseCase.execute(movieId: self.movieId) { [weak self] movie in
            self?.movie = movie
            self?.isMovieDetailsLoading = false
        } failure: { error in
            self.error = error
            self.isMovieDetailsLoading = false
        }
    }
    
    func loadMovieCast() {
        getMovieCastUseCase.execute(
            movieId: movieId,
            success: { [weak self] credits in
                self?.castMembers = credits.cast
                self?.crewMembers = credits.crew
                self?.isCreditsLoading = false
            },
            failure: { [weak self] error in
                self?.error = error
                self?.isCreditsLoading = false
            }
        )
    }
    
    func loadSimilarMovies() {
        getSimilarMoviesUseCase.execute(
            movieId: movieId,
            success: { [weak self] similarMovies in
                self?.similarMovies = similarMovies
                self?.isSimilarMoviesLoading = false
            },
            failure: { [weak self] error in
                self?.error = error
                self?.isSimilarMoviesLoading = false
            }
        )
    }
}
