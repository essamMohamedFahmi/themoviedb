//
//  MovieCategory.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

enum MovieCategory {
    case nowPlaying
    case popular
    case upcoming
    
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
