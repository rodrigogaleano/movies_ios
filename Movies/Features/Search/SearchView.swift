//
//  SearchView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 12/11/24.
//

import SwiftUI

protocol SearchViewProtocol: ObservableObject {
    var searchText: String { get set }
}

struct SearchView<ViewModel: SearchViewProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            TextField("Search for a movie", text: Binding(
                get: { viewModel.searchText },
                set: { viewModel.searchText = $0 }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
    }
}

#Preview {
    SearchFactory.search()
}
