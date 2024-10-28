//
//  ContentView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    var nowPlayingMoviesViewModels: [any MovieItemProtocol] { get }
    var popularMoviesViewModels: [any MovieItemProtocol] { get }
    var topRatedMoviesViewModels: [any MovieItemProtocol] { get }
    
    func loadMovies()
}

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Movies")
                    .font(.largeTitle.bold())
                MoviesSectionView(
                    title: "Now Playing",
                    viewModels: viewModel.nowPlayingMoviesViewModels
                )
                MoviesSectionView(
                    title: "Top Rated",
                    viewModels: viewModel.topRatedMoviesViewModels
                )
                MoviesSectionView(
                    title: "Popular",
                    viewModels: viewModel.popularMoviesViewModels
                )
            }
            .padding()
        }
        .onAppear {
            viewModel.loadMovies()
        }
    }
}

#Preview {
    HomeFactory.home()
}

