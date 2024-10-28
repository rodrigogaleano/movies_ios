//
//  MoviesSectionView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import SwiftUI

struct MoviesSectionView: View {
    var title: String
    var viewModels: [any MovieItemProtocol]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                if viewModels.isEmpty {
                    ProgressView()
                } else {
                    HStack(spacing: 12) {
                        ForEach(viewModels.indices, id: \.self) { index in
                            MovieItemView(viewModel: viewModels[index])
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
        Movie(id: 1, title: "Movie 1", posterPath: "/7fR3KxswtY8OHHZuOUB9td58CRX.jpg"),
        Movie(id: 2, title: "Movie 2", posterPath: "/9gK0r7FYwP51cJvH0WYQ8xPcih4.jpg"),
        Movie(id: 3, title: "Movie 3", posterPath: "/l6gq4Wc9W0RSmGGN21eFQ9XzA9M.jpg"),
        Movie(id: 4, title: "Movie 4", posterPath: "/oBhmmsDh0DumEuYOV4fPRzpQQyX.jpg"),
        Movie(id: 5, title: "Movie 5", posterPath: "/sYqzSklV2ptKGAthd6qYb1mWteD.jpg"),
        Movie(id: 6, title: "Movie 6", posterPath: "/6gI1y0CLQuG0GiXq5BBqZbfAfNy.jpg"),
    ]
    
    let viewModels: [MovieItemViewModel] = movies.map { MovieItemViewModel(movie: $0) }
    
    return MoviesSectionView(title: "Now Playing", viewModels: viewModels)
}
