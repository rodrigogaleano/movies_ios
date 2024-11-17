//
//  InstructionView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 16/11/24.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title)
            Text("Search for a movie")
            Spacer()
        }
    }
}

#Preview {
    InstructionView()
}
