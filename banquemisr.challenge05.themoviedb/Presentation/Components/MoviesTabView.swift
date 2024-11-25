//
//  MoviesTabView.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import SwiftUI

enum MovieCategory: String {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
    
    var displayName: String {
        switch self {
        case .nowPlaying:
            "Now Playing"
        case .popular:
            "Popular"
        case .upcoming:
            "Upcoming"
        }
    }
}

struct MoviesTabView: View {
    private let factory: PresentationFactory

    init(factory: PresentationFactory) {
        self.factory = factory
    }

    var body: some View {
        TabView {
            MovieListView(category: .nowPlaying, factory: factory)
                .tabItem {
                    Label("Now Playing", systemImage: "film")
                }

            MovieListView(category: .popular, factory: factory)
                .tabItem {
                    Label("Popular", systemImage: "star")
                }

            MovieListView(category: .upcoming, factory: factory)
                .tabItem {
                    Label("Upcoming", systemImage: "calendar")
                }
        }
    }
}
