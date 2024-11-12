//
//  DetailBadgeView.swift
//  Movies
//
//  Created by Rodrigo Galeano on 10/11/24.
//

import SwiftUI

struct DetailBadgeView: View {
    var text: String
    var icon: Image?
    
    var body: some View {
        HStack {
            icon
                .foregroundStyle(.yellow)
            Text(text)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    DetailBadgeView(text: "Text")
}
