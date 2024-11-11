//
//  DefaultScreen.swift
//  Movies
//
//  Created by Rodrigo Galeano on 10/11/24.
//


import SwiftUI

struct DefaultScreen: View {
    var content: some View
    
    var body: some View {
        ZStack {
            Color.black
            content
        }
    }
}
