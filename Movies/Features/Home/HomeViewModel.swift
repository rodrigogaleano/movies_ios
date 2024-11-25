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
    
    private let getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
    private let getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol
    private let getNowPlayingMoviesUseCase: GetNowPlayingMoviesUseCaseProtocol
    
    init(
        getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol,
        getTopRatedMoviesUseCase: GetTopRatedMoviesUseCaseProtocol,
        getNowPlayingMoviesUseCase: GetNowPlayingMoviesUseCaseProtocol
    ) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.getTopRatedMoviesUseCase = getTopRatedMoviesUseCase
        self.getNowPlayingMoviesUseCase = getNowPlayingMoviesUseCase
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
        getNowPlayingMoviesUseCase.execute(
            success: { [weak self] movies in
                self?.nowPlayingMovies = movies
                self?.isNowPlayingLoading = false
            },
            failure: { error in
                self.errorMessage = error
                self.isNowPlayingLoading = false
            }
        )
    }
    
    func fetchPopularMovies() {
        getPopularMoviesUseCase.execute(
            success: { [weak self] movies in
                self?.popularMovies = movies
                self?.isPopularLoading = false
            },
            failure: { error in
                self.errorMessage = error
                self.isPopularLoading = false
            }
        )
    }
    
    func fetchTopRatedMovies() {
        getTopRatedMoviesUseCase.execute(
            success: { [weak self] movies in
                self?.topRatedMovies = movies
                self?.isTopRatedLoading = false
            },
            failure: { error in
                self.errorMessage = error
                self.isTopRatedLoading = false
            }
        )
    }
}
