//
//  ContentView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    var nowPlayingMoviesViewModels: [any CarouselItemProtocol] { get }
    var popularMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    var topRatedMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    
    func loadMovies()
}

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    
    @State private var currentCarouselIndex = 0
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Now Playing")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                TabView(selection: $currentCarouselIndex) {
                    ForEach(viewModel.nowPlayingMoviesViewModels.indices, id: \.self) { index in
                        CarouselItemView(viewModel: viewModel.nowPlayingMoviesViewModels[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 200)
                MoviesSectionView(
                    title: "Top Rated",
                    viewModels: viewModel.topRatedMoviesViewModels
                )
                MoviesSectionView(
                    title: "Popular",
                    viewModels: viewModel.popularMoviesViewModels
                )
            }
            .padding(.bottom, 40)
        }
        .onAppear {
            viewModel.loadMovies()
            // TODO: Stop timer on disappear screen
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 1)) {
                    if currentCarouselIndex == viewModel.nowPlayingMoviesViewModels.count - 1 {
                        currentCarouselIndex = 0
                    } else {
                        currentCarouselIndex += 1
                    }
                }
            }
        }
    }
}

#Preview {
    HomeFactory.home()
}

