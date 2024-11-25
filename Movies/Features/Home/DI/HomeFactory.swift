//
//  HomeFactory.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

enum HomeFactory {
    static func home() -> some View {
        let movieRoutes = MovieRoutes()
        let getPopularMoviesUseCase = GetPopularMoviesUseCase(movieRoutes: movieRoutes)
        let getTopRatedMoviesUseCase = GetTopRatedMoviesUseCase(movieRoutes: movieRoutes)
        let getNowPlayingMoviesUseCase = GetNowPlayingMoviesUseCase(movieRoutes: movieRoutes)
        let viewModel = HomeViewModel(
            getPopularMoviesUseCase: getPopularMoviesUseCase,
            getTopRatedMoviesUseCase: getTopRatedMoviesUseCase,
            getNowPlayingMoviesUseCase: getNowPlayingMoviesUseCase
        )
        
        return HomeView(viewModel: viewModel)
    }
}
