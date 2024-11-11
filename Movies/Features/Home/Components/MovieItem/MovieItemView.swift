//
//  MovieItemView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import SwiftUI

protocol MovieItemViewModelProtocol {
    var movieId: Int { get }
    var title: String { get }
    var imageUrl: URL? { get }
}

struct MovieItemView: View {
    var viewModel: any MovieItemViewModelProtocol
    
    var body: some View {
        NavigationLink(
            destination: {
                MovieDetailsFactory.MovieDetails(movieId: viewModel.movieId)
            },
            label: {
                VStack {
                    AsyncImage(url: viewModel.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                    }

                    Text(viewModel.title)
                        .font(.callout)
                        .foregroundStyle(.black)
                }
                .frame(width: 140)
            }
        )
    }
}

#Preview {
    let viewModel = MovieItemViewModel(movie: moviesMock[0])
    
    MovieItemView(viewModel: viewModel)
}
