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
        Text("Hello, world!")
            .onAppear {
                viewModel.loadMovies()
            }
    }
}
