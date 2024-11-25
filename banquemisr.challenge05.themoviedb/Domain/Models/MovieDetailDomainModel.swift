//
//  MovieDetailDomainModel.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct MovieDetailDomainModel {
    let id: Int
    let title, overview: String
    let budget, revenue, runtime: Int
    let imdbID: String
    let popularity: Double
    let posterURL: URL
    let releaseDate: Date
}
