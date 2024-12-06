//
//  CrewMemberItemView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 06/12/24.
//

import SwiftUI

protocol CrewMemberItemViewModelProtocol {
    var job: String { get }
    var name: String { get }
    var imageURL: URL? { get }
}

struct CrewMemberItemView: View {
    
    var viewModel: any CrewMemberItemViewModelProtocol
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.secondary)
                    .frame(width: 48, height: 48)
            }
            VStack(alignment: .leading) {
                Text(viewModel.name)
                Text(viewModel.job)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    CrewMemberItemView(
        viewModel: CrewMemberItemViewModel(
            crewMember: CrewMember(
                job: "Job",
                name: "Name",
                profilePath: "/7LqmE3p1XTwCdNCOmBxovq210Qk.jpg"
            )
        )
    )
}
