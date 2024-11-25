//
//  TheMovieDBApp.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by Essam Fahmy on 12/08/2024.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesTabView(
                factory: PresentationFactory()
            )
        }
    }
}
