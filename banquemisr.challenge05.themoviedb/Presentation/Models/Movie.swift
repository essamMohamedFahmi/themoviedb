//
//  MovieViewModel.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct Movie: Identifiable, Equatable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterURL: URL?

    init(from movie: MovieDomainModel) {
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = movie.releaseDate.toDisplayDate()
        self.posterURL = movie.posterURL
    }
}
