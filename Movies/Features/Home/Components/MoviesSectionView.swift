//
//  MoviesSectionView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import SwiftUI

struct MoviesSectionView: View {
    var title: String
    var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.title)
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(movies, id: \.id) { movie in
                        Rectangle()
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text(movie.title)
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesSectionView(title: "Example", movies: [
        Movie(id: 1, title: "Movie 1", posterPath: ""),
        Movie(id: 2, title: "Movie 2", posterPath: ""),
        Movie(id: 3, title: "Movie 3", posterPath: ""),
        Movie(id: 4, title: "Movie 4", posterPath: ""),
        Movie(id: 5, title: "Movie 5", posterPath: ""),
        Movie(id: 6, title: "Movie 6", posterPath: ""),
    ])
}
