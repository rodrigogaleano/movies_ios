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
}

struct CarouselItemView: View {
    var viewModel:  any CarouselItemProtocol
    
    var body: some View {
        NavigationLink {
            MovieDetailsFactory.MovieDetails(movieId: viewModel.movieId)
        } label: {
            AsyncImage(url: viewModel.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    CarouselItemView(
        viewModel: CarouselItemViewModel(
            movie: Movie(
                id: 1,
                title: "Título",
                posterPath: "https://image.tmdb.org/t/p/original/gCI2AeMV4IHSewhJkzsur5MEp6R.jpg",
                backdropPath: "https://image.tmdb.org/t/p/original/gwj4R8Uy1GwejKqfofREKI9Jh7L.jpg"
            )
        )
    )
}
