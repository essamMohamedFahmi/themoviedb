//
//  MovieService.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Combine
import Foundation

// MARK: - MovieService

protocol MovieService {
    func fetchMovies(category: String) -> AnyPublisher<MovieList, MovieDBError>
    func movieDetails(movieID: Int) -> AnyPublisher<MovieDetailDataModel, MovieDBError>
}

// MARK: - MovieServiceProvider

class MovieServiceProvider: MovieService {
    private let apiClient = URLSessionAPIClient<MovieEndpoint>()

    func fetchMovies(category: String) -> AnyPublisher<MovieList, MovieDBError> {
        apiClient.request(MovieEndpoint.fetchMovies(category: category))
    }
    
    func movieDetails(movieID: Int) -> AnyPublisher<MovieDetailDataModel, MovieDBError> {
        apiClient.request(MovieEndpoint.movieDetails(movieID: movieID))
    }
}
