//
//  ErrorView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 16/11/24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "exclamationmark.circle")
                .font(.title)
            Text(errorMessage)
            Spacer()
        }
    }
}

#Preview {
    ErrorView(errorMessage: "Error")
}
