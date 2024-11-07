//
//  HomeViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import Foundation

class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    @Published private var popularMovies: [Movie] = []
    @Published private var topRatedMovies: [Movie] = []
    @Published private var nowPlayingMovies: [Movie] = []
    
    // MARK: - Init
    
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    // MARK: - Public Getters
    
    var nowPlayingMoviesViewModels: [any CarouselItemProtocol] {
        nowPlayingMovies.map { CarouselItemViewModel(movie: $0) }
    }
    
    var popularMoviesViewModels: [any MovieItemViewModelProtocol] {
        popularMovies.map { MovieItemViewModel(movie: $0) }
    }
    
    var topRatedMoviesViewModels: [any MovieItemViewModelProtocol] {
        topRatedMovies.map { MovieItemViewModel(movie: $0) }
    }

    // MARK: - Public Methods
    
    func loadMovies() {
        fetchNowPlayingMovies()
        fetchPopularMovies()
        fetchTopRatedMovies()
    }
    
    // MARK: - Private Methods
    
    private func fetchNowPlayingMovies() {
        moviesRepository.fetchNowPlayingMovies(
            success: { [weak self] movies in
                self?.nowPlayingMovies = movies
            },
            failure: { error in
                print("Erro ao carregar filmes: \(error)")
            }
        )
    }
    
    private func fetchPopularMovies() {
        moviesRepository.fetchPopularMovies(
            success: { [weak self] movies in
                self?.popularMovies = movies
            },
            failure: { error in
                print("Erro ao carregar filmes: \(error)")
            }
        )
    }
    
    private func fetchTopRatedMovies() {
        moviesRepository.fetchTopRatedMovies(
            success: { [weak self] movies in
                self?.topRatedMovies = movies
            },
            failure: { error in
                print("Erro ao carregar filmes: \(error)")
            }
        )
    }
}
