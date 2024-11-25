//
//  MovieMapper.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Foundation

struct MovieMapper {
    private let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    func mapToDomain(_ movies: [MovieDataModel]) -> [MovieDomainModel] {
        movies.map { mapToDomain($0) }
    }
    
    func mapToDomain(_ movie: MovieDataModel) -> MovieDomainModel {
        let posterURL = URL(string: posterBaseURL + movie.posterPath)!
        let releaseDate = DateFormatter.apiFormatter.date(from: movie.releaseDate) ?? Date()
        
        return MovieDomainModel(
            id: movie.id,
            title: movie.title,
            releaseDate: releaseDate,
            posterURL: posterURL
        )
    }
    
    func mapToDomain(_ movieDetail: MovieDetailDataModel) -> MovieDetailDomainModel {
        let posterURL = URL(string: posterBaseURL + movieDetail.posterPath)!
        let releaseDate = DateFormatter.apiFormatter.date(from: movieDetail.releaseDate) ?? Date()
        
        return MovieDetailDomainModel(
            id: movieDetail.id,
            title: movieDetail.title,
            overview: movieDetail.overview,
            budget: movieDetail.budget,
            revenue: movieDetail.revenue,
            runtime: movieDetail.runtime,
            imdbID: movieDetail.imdbID,
            popularity: movieDetail.popularity,
            posterURL: posterURL,
            releaseDate: releaseDate
        )
    }
}
