//
//  MovieModels.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Foundation

// MARK: - Remote Models

struct MovieList: Codable, Equatable {
    let results: [MovieDataModel]
}

struct MovieDataModel: Codable, Equatable {
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

struct MovieDetailDataModel: Codable, Equatable {
    let id: Int
    let title, overview: String
    let budget, revenue, runtime: Int
    let imdbID: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, budget, revenue, runtime, popularity
        case imdbID = "imdb_id"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
