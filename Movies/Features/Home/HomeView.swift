//
//  ContentView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var errorMessage: String { get }
    var nowPlayingMoviesViewModels: [any CarouselItemProtocol] { get }
    var popularMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    var topRatedMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    
    func loadMovies()
}


struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var carouselTimer: Timer?
    @State private var currentCarouselIndex = 0
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    LoadingView()
                }
                else if !viewModel.errorMessage.isEmpty {
                    ErrorView(errorMessage: viewModel.errorMessage)
                } else {
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
                }
            }
            .navigationTitle("Movies")
            .toolbarTitleDisplayMode(.inlineLarge)
            .onAppear {
                viewModel.loadMovies()
                startCarouselTimer()
            }
            .onDisappear {
                stopCarouselTimer()
            }
        }
    }
    
    private func startCarouselTimer() {
        stopCarouselTimer()
        carouselTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 1)) {
                if currentCarouselIndex == viewModel.nowPlayingMoviesViewModels.count - 1 {
                    currentCarouselIndex = 0
                } else {
                    currentCarouselIndex += 1
                }
            }
        }
    }
    
    private func stopCarouselTimer() {
        carouselTimer?.invalidate()
        carouselTimer = nil
    }
}

#Preview {
    HomeFactory.home()
}

