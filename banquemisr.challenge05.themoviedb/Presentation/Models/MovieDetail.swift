//
//  MovieDetail.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct MovieDetail: Identifiable {
    let id: Int
    let title, overview: String
    let budget, revenue, runtime: Int
    let imdbID: String
    let popularity: Double
    let releaseDate: String
    let posterURL: URL?

    init(from movie: MovieDetailDomainModel) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.budget = movie.budget
        self.revenue = movie.revenue
        self.runtime = movie.runtime
        self.imdbID = movie.imdbID
        self.popularity = movie.popularity
        self.releaseDate = DateFormatter.displayFormatter.string(from: movie.releaseDate)
        self.posterURL = movie.posterURL
    }
}
