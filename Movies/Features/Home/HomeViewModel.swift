//
//  HomeViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import Foundation

class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    
    // MARK: - Public
    
    @Published var movies: [Movie] = []
    
    // MARK: - Init
    
    private let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    // MARK: - Public Methods
    
    func loadMovies() {
        moviesRepository.fetchNowPlayingMovies(
            success: { [weak self] movies in
                self?.movies = movies
                print("Filmes carregados: \(movies)")
            },
            failure: { error in
                print("Erro ao carregar filmes: \(error)")
            }
        )
    }
}
