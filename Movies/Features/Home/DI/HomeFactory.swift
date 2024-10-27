//
//  HomeFactory.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

enum HomeFactory {
    static func home() -> some View {
        let moviesRepository = MoviesRepository(routes: MovieRoutes())
        let viewModel = HomeViewModel(moviesRepository: moviesRepository)
        
        return HomeView(viewModel: viewModel)
    }
}
