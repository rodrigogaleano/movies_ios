//
//  DefaultColoredBackground.swift
//  Movies
//
//  Created by Rodrigo Galeano on 11/11/24.
//

import SwiftUI

struct DefaultColoredBackground<Content: View>: View {
    var backgroundColor: Color = .black
    let content: Content
    
    init(backgroundColor: Color = .black, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            content
        }
    }
}

#Preview {
    DefaultColoredBackground(backgroundColor: .blue) {
        VStack {
            Text("Hello, World!")
                .foregroundColor(.white)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
    }
}
