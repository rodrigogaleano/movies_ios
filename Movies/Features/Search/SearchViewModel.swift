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
    @Published  var isLoading: Bool = false
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
        print("Starting search for: \(searchText)") // Deb
    
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            guard !self.searchText.isEmpty else {
                print("Search text is empty")
                return
            }
            self.isLoading = true
            print("Loading started...") // Debuggingugging
            
   
            
            self.moviesRepository.fetchSearchedMovies(query: self.searchText) { searchedMovies in
                self.searchedMovies = searchedMovies
                print("Movies fetched: \(searchedMovies.count)") // Debugging
            } failure: { error in
                // TODO: Handle error
                print("Error fetching movies: \(error)")
            } onComplete: {
                self.isLoading = false
                print("Loading complete.") // Debugging
            }
        }
    }
    
}
