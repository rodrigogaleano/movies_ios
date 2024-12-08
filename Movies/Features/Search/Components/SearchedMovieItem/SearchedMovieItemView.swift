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
    var overview: String { get }
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
                VStack(alignment: .leading) {
                    Text(viewModel.movieTitle)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text(viewModel.overview)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .foregroundStyle(.black)
            .frame(height: 96)
            .padding(.vertical)
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
