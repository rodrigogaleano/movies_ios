//
//  NoResultsView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 16/11/24.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .font(.title)
            Text("No movies found")
            Spacer()
        }
    }
}

#Preview {
    NoResultsView()
}
