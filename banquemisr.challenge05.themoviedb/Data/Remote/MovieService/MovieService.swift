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
    func fetchMovies(category: String) -> AnyPublisher<MovieList, APIError>
    func movieDetails(movieID: Int) -> AnyPublisher<MovieDetailDataModel, APIError>
}

// MARK: - MovieServiceProvider

class MovieServiceProvider: MovieService {
    private let apiClient = URLSessionAPIClient<MovieEndpoint>()

    func fetchMovies(category: String) -> AnyPublisher<MovieList, APIError> {
        apiClient.request(MovieEndpoint.fetchMovies(category: category))
    }
    
    func movieDetails(movieID: Int) -> AnyPublisher<MovieDetailDataModel, APIError> {
        apiClient.request(MovieEndpoint.movieDetails(movieID: movieID))
    }
}
