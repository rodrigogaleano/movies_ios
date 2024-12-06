//
//  CastMemberItemView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 02/12/24.
//

import SwiftUI

protocol CastMemberItemViewModelProtocol {
    var name: String { get }
    var character: String { get }
    var imageURL: URL? { get }
}

struct CastMemberItemView: View {
    let viewModel: any CastMemberItemViewModelProtocol
    
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
                Text(viewModel.character)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    CastMemberItemView(
        viewModel: CastMemberItemViewModel(
            castMember: CastMember(
                name: "Name",
                character: "Character",
                profilePath: "/7LqmE3p1XTwCdNCOmBxovq210Qk.jpg"
            )
        )
    )
}
