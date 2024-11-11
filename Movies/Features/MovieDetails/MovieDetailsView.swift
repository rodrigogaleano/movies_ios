//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/11/24.
//

import SwiftUI

protocol MovieDetailViewModelProtocol: ObservableObject {
    var genre: String { get }
    var title: String { get }
    var runtime: String { get }
    var overview: String { get }
    var releaseYear: String { get }
    var voteAverage: String { get }
    var similarMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    
    
    var backdropURL: URL? { get }
    
    func loadContent()
}

struct MovieDetailsView<ViewModel: MovieDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        DefaultColoredBackground {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    AsyncImage(url: viewModel.backdropURL) { image in
                        image
                            .resizable()
                            .mask {
                                LinearGradient(
                                    colors: [.black, .clear],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 300)
                    Text(viewModel.title)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    HStack(spacing: 10) {
                        DetailBadgeView(text: viewModel.genre)
                        DetailBadgeView(text: viewModel.releaseYear)
                        DetailBadgeView(text: viewModel.runtime)
                        DetailBadgeView(text: viewModel.voteAverage, icon: Image(systemName: "star.fill"))
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    Text(viewModel.overview)
                        .padding(.horizontal)
                    MoviesSectionView(
                        title: "Similar Movies",
                        viewModels: viewModel.similarMoviesViewModels
                    )
                }
                .foregroundStyle(.white)
                .onAppear {
                    viewModel.loadContent()
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    MovieDetailsFactory.MovieDetails(movieId: 278)
}
