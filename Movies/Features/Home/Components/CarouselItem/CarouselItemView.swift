//
//  NowPlayingMoviesCarouselView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 06/11/24.
//

import SwiftUI

protocol CarouselItemProtocol {
    var movieId: Int { get }
    var imageUrl: URL? { get }
    var movieTitle: String { get }
}

struct CarouselItemView: View {
    var viewModel:  any CarouselItemProtocol
    
    var body: some View {
        NavigationLink {
            MovieDetailsFactory.MovieDetails(movieId: viewModel.movieId)
        } label: {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: viewModel.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                Text(viewModel.movieTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(height: 200)
        }
    }
}

#Preview {
    CarouselItemView(
        viewModel: CarouselItemViewModel(
            movie: moviesMock[0]
        )
    )
}
