//
//  MoviesSectionView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import SwiftUI

struct MoviesSectionView: View {
    var title: String
    var viewModels: [any MovieItemViewModelProtocol]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                if viewModels.isEmpty {
                    ProgressView()
                } else {
                    HStack(spacing: 12) {
                        ForEach(viewModels.indices, id: \.self) { index in
                            MovieItemView(viewModel: viewModels[index])
                                .padding(.leading, index == 0 ? 16 : 0)
                                .padding(.trailing, index == viewModels.count - 1 ? 16 : 0)
                        }
                    }
                }
            }
            .frame(height: 200)
        }
    }
}

#Preview {
    let movies = [
        Movie(
            id: 1, 
            title: "Movie 1",
            posterPath: "/7fR3KxswtY8OHHZuOUB9td58CRX.jpg",
            backdropPath: "https://image.tmdb.org/t/p/original/gwj4R8Uy1GwejKqfofREKI9Jh7L.jpg"
        ),
        Movie(
            id: 2,
            title: "Movie 2",
            posterPath: "/7fR3KxswtY8OHHZuOUB9td58CRX.jpg",
            backdropPath: "https://image.tmdb.org/t/p/original/gwj4R8Uy1GwejKqfofREKI9Jh7L.jpg"
        )
    ]
    
    let viewModels: [MovieItemViewModel] = movies.map {
        MovieItemViewModel(movie: $0)
    }
    
    MoviesSectionView(title: "Now Playing", viewModels: viewModels)
}
