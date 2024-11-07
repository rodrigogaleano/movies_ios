//
//  MoviesApp.swift
//  Movies
//
//  Created by Rodrigo Galeano on 01/08/24.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeFactory.home()
            }
        }
    }
}
