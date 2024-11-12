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
    
    var backdropURL: URL? { get }
    var castMembersImageURLs: [URL] { get }
    
    var similarMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    
    func loadContent()
}

struct MovieDetailsView<ViewModel: MovieDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
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
                Text("Cast")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.castMembersImageURLs.indices, id: \.self) { index in
                            AsyncImage(url: viewModel.castMembersImageURLs[index]) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 92, height: 92)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 92, height: 92)
                            }
                            .padding(.leading, index == 0 ? 16 : 0)
                            .padding(.trailing, index == viewModel.castMembersImageURLs.count - 1 ? 16 : 0)
                        }
                    }
                }
                MoviesSectionView(
                    title: "Similar Movies",
                    viewModels: viewModel.similarMoviesViewModels
                )
            }
        }
        .navigationTitle("Movie Details")
        .toolbarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadContent()
        }
    }
}

#Preview {
    MovieDetailsFactory.MovieDetails(movieId: 278)
}
