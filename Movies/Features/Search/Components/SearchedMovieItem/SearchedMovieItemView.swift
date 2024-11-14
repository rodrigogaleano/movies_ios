//
//  SearchedMovieItemView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 14/11/24.
//

import SwiftUI

protocol SearchedMovieItemProtocol {
    var movieId: Int { get }
    var imageUrl: URL? { get }
    var movieTitle: String { get }
}

struct SearchedMovieItemView: View {
    var viewModel:  any SearchedMovieItemProtocol
    
    var body: some View {
        NavigationLink {
            MovieDetailsFactory.MovieDetails(movieId: viewModel.movieId)
        } label: {
            HStack {
                AsyncImage(url: viewModel.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 96, height: 96)
                }
                Text(viewModel.movieTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 8)
                Spacer()
            }
            .frame(height: 96)
            .padding()
        }
    }
}

#Preview {
    SearchedMovieItemView(
        viewModel: SearchedMovieItemViewModel(
            movie: moviesMock[0]
        )
    )
}
