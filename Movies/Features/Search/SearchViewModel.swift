//
//  SearchViewModel.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import SwiftUI

class SearchViewModel: SearchViewProtocol, ObservableObject {
    // MARK: - Private Properties
    
    private var timer: Timer?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published private var searchedMovies: [Movie] = []
    
    
    // MARK: - Init
    
    let moviesRepository: MoviesRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    // MARK: - Public Properties
    
    @Published var searchText: String = "" {
        didSet {
            getSearchedMovies()
        }
    }
    
    
    var searchMoviesViewModels: [any SearchedMovieItemProtocol] {
        searchedMovies.map { SearchedMovieItemViewModel(movie: $0) }
    }
    
    // MARK: - Private Methods
    
    private func getSearchedMovies() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            guard !self.searchText.isEmpty else { return }
            self.isLoading = true
            self.errorMessage = ""
            self.moviesRepository.fetchSearchedMovies(query: self.searchText) { searchedMovies in
                self.searchedMovies = searchedMovies
            } failure: { error in
                self.errorMessage = error
            } onComplete: {
                self.isLoading = false
            }
        }
    }
    
}
