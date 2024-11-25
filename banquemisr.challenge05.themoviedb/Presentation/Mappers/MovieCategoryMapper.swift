//
//  MovieCategoryMapper.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct MovieCategoryMapper {
    static func toKey(_ category: MovieCategory) -> String {
        switch category {
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        case .upcoming:
            return "upcoming"
        }
    }
}
