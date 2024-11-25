//
//  HomeViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import Foundation


class HomeViewModel {
    @Published var errorMessage: String = ""
    @Published private var isPopularLoading: Bool = true
    @Published private var isTopRatedLoading: Bool = true
    @Published private var isNowPlayingLoading: Bool = true
    @Published private var popularMovies: [Movie] = []
    @Published private var topRatedMovies: [Movie] = []
    @Published private var nowPlayingMovies: [Movie] = []
    
    // MARK: - Init
    
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    var nowPlayingMoviesViewModels: [any CarouselItemProtocol] {
        nowPlayingMovies.map { CarouselItemViewModel(movie: $0) }
    }
    
    var popularMoviesViewModels: [any MovieItemViewModelProtocol] {
        popularMovies.map { MovieItemViewModel(movie: $0) }
    }
    
    var topRatedMoviesViewModels: [any MovieItemViewModelProtocol] {
        topRatedMovies.map { MovieItemViewModel(movie: $0) }
    }
    
    var isLoading: Bool {
        isPopularLoading || isTopRatedLoading || isNowPlayingLoading
    }
    
    func loadMovies() {
        fetchNowPlayingMovies()
        fetchPopularMovies()
        fetchTopRatedMovies()
    }
}

private extension HomeViewModel {
    func fetchNowPlayingMovies() {
        moviesRepository.fetchNowPlayingMovies(
            success: { [weak self] movies in
                self?.nowPlayingMovies = movies
            },
            failure: { error in
                self.errorMessage = error
            },
            onComplete: {
                self.isNowPlayingLoading = false
            }
        )
    }
    
    func fetchPopularMovies() {
        moviesRepository.fetchPopularMovies(
            success: { [weak self] movies in
                self?.popularMovies = movies
            },
            failure: { error in
                self.errorMessage = error
            },
            onComplete: {
                self.isPopularLoading = false
            }
        )
    }
    
    func fetchTopRatedMovies() {
        moviesRepository.fetchTopRatedMovies(
            success: { [weak self] movies in
                self?.topRatedMovies = movies
            },
            failure: { error in
                self.errorMessage = error
            },
            onComplete: {
                self.isTopRatedLoading = false
            }
        )
    }
}
