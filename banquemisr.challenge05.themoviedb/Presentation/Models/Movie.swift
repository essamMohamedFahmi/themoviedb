//
//  MovieViewModel.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterURL: URL?

    init(from movie: MovieDomainModel) {
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = DateFormatter.displayFormatter.string(from: movie.releaseDate)
        self.posterURL = movie.posterURL
    }
}
