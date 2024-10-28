//
//  MovieItemView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 27/10/24.
//

import SwiftUI

protocol MovieItemProtocol: ObservableObject {
    var title: String { get }
    var imageUrl: URL? { get }
}

struct MovieItemView: View {
     var viewModel: any MovieItemProtocol
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.imageUrl)
                .frame(width: 128, height: 180)
                .clipShape(.rect(cornerRadius: 8))
            Text(viewModel.title)
                .font(.callout)
        }.frame(width: 128)
    }
}

#Preview {
    let movie = Movie(id: 1, title: "Movie Title", posterPath: "/path/to/poster.jpg")
    let viewModel = MovieItemViewModel(movie: movie)
    
    MovieItemView(viewModel: viewModel)
}
