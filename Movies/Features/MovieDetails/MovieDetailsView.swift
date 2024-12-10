//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/11/24.
//

import SwiftUI

protocol MovieDetailViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    
    var genre: String { get }
    var title: String { get }
    var runtime: String { get }
    var director: String { get }
    var overview: String { get }
    var countries: [String] { get }
    var releaseYear: String { get }
    var voteAverage: String { get }
    var errorMessage: String { get }
    var originalLanguage: String { get }
    
    var genres: [String] { get }
    var productionCompanies: [String] { get }
    
    var posterURL: URL? { get }
    var backdropURL: URL? { get }
    var castMembersImageURLs: [URL] { get }
    
    var similarMoviesViewModels: [any MovieItemViewModelProtocol] { get }
    var castMembersViewModels: [any CastMemberItemViewModelProtocol] { get }
    var crewMembersViewModels: [any CrewMemberItemViewModelProtocol] { get }
    
    func loadContent()
}

struct MovieDetailsView<ViewModel: MovieDetailViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @State var tabSelectedValue = 0
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            }  else if !viewModel.errorMessage.isEmpty {
                ErrorView(errorMessage: viewModel.errorMessage)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { geometry in
                            AsyncImage(url: viewModel.backdropURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: 300)
                                    .mask {
                                        LinearGradient(
                                            colors: [.black, .clear],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                            } placeholder: {
                                ProgressView()
                                    .frame(width: geometry.size.width, height: 300)
                            }
                        }
                        .frame(height: 300)
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(viewModel.title)
                                        .font(.title2)
                                        .bold()
                                    Text(viewModel.releaseYear + " - DIRECTED BY")
                                    Text(viewModel.director)
                                        .bold()
                                    Text(viewModel.runtime)
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                        Text(viewModel.voteAverage)
                                    }
                                }
                                Spacer()
                                AsyncImage(url: viewModel.posterURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(8)
                                        .frame(width: 140)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 140)
                                }
                            }
                            Text(viewModel.overview)
                            Picker(selection: $tabSelectedValue, label: Text("Infos")) {
                                Text("Cast")
                                    .tag(0)
                                Text("Crew")
                                    .tag(1)
                                Text("Details")
                                    .tag(2)
                                Text("Genres")
                                    .tag(3)
                            }
                            .pickerStyle(.segmented)
                            switch tabSelectedValue {
                            case 0:
                                LazyVStack(alignment: .leading) {
                                    ForEach(viewModel.castMembersViewModels.indices, id: \.self) { index in
                                        CastMemberItemView(viewModel: viewModel.castMembersViewModels[index])
                                        Divider()
                                    }
                                }
                            case 1:
                                LazyVStack(alignment: .leading) {
                                    ForEach(viewModel.crewMembersViewModels.indices, id: \.self) { index in
                                        CrewMemberItemView(viewModel: viewModel.crewMembersViewModels[index])
                                        Divider()
                                    }
                                }
                            case 2:
                                LazyVStack(alignment: .leading) {
                                    Section(
                                        header: Text("Production Companies")
                                            .fontWeight(.semibold)
                                            .padding(.vertical)
                                    ) {
                                        Divider()
                                        ForEach(viewModel.productionCompanies, id: \.self) { company in
                                            Text(company)
                                            Divider()
                                        }
                                    }
                                    Section(
                                        header: Text("Countries")
                                            .fontWeight(.semibold)
                                            .padding(.vertical)
                                    ) {
                                        Divider()
                                        ForEach(viewModel.countries, id: \.self) { country in
                                            Text(country)
                                            Divider()
                                        }
                                    }
                                    Section(
                                        header: Text("Original Language")
                                            .fontWeight(.semibold)
                                            .padding(.vertical)
                                    ) {
                                        Divider()
                                        Text(viewModel.originalLanguage)
                                        Divider()
                                    }
                                }
                            case 3:
                                LazyVStack(alignment: .leading) {
                                    ForEach(viewModel.genres.indices, id: \.self) { index in
                                        Text(viewModel.genres[index])
                                        Divider()
                                    }
                                }
                            default:
                                LoadingView()
                            }
                            MoviesSectionView(
                                title: "Similar Movies",
                                viewModels: viewModel.similarMoviesViewModels
                            )
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Movie Details")
        .toolbarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadContent()
        }
    }
}

#Preview {
    MovieDetailsFactory.MovieDetails(movieId: 278)
}
