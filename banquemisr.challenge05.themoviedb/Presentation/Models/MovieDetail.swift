//
//  MovieDetail.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct MovieDetail: Identifiable, Equatable {
    let id: Int
    let title, overview: String
    let budget, revenue, runtime: String
    let imdbURL: URL?
    let popularity: String
    let releaseDate: String
    let posterURL: URL?

    init(from movie: MovieDetailDomainModel) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.budget = "Budget: $\(movie.budget)"
        self.revenue = "Revenue: $\(movie.revenue)"
        self.runtime = "Runtime: \(movie.runtime) minutes"
        self.imdbURL = URL(string: "https://www.imdb.com/title/\(movie.imdbID)")
        self.popularity = "Popularity: \(String(format: "%.1f", movie.popularity))"
        self.releaseDate = "Release Date: \(movie.releaseDate.toDisplayDate())"
        self.posterURL = movie.posterURL
    }
}
