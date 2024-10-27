//
//  ContentView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    func loadMovies()
}

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Movies").font(.largeTitle.bold())
            MoviesSectionView(title: "Now Playing", movies: viewModel.movies)
        }
        .padding()
        .onAppear {
            viewModel.loadMovies()
        }
    }
}

#Preview {
    HomeFactory.home()
}

