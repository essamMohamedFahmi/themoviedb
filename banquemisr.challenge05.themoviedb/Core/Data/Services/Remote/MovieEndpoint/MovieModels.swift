//
//  MovieModels.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Foundation

enum MovieCategory: String {
    case nowPlaying = "now_playing"
    case popular = "popular"
    case upcoming = "upcoming"
}

// MARK: - Remote Models

struct MovieList: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
