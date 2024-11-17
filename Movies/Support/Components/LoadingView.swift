//
//  LoadingView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 16/11/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            if #available(iOS 18.0, *) {
                Image(systemName: "movieclapper")
                    .symbolEffect(.bounce, options: .repeat(.continuous))
                    .font(.title)
            } else {
                Image(systemName: "movieclapper")
                    .font(.title)
            }
            Text("Loading...")
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
