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
    func fetchMovies(category: MovieCategory) -> AnyPublisher<MovieList, APIError>
    func movieDetails(movieID: Int) -> AnyPublisher<Movie, APIError>
}

// MARK: - MovieServiceProvider

class MovieServiceProvider: MovieService {
    private let apiClient = URLSessionAPIClient<MovieEndpoint>()

    func fetchMovies(category: MovieCategory) -> AnyPublisher<MovieList, APIError> {
        apiClient.request(MovieEndpoint.fetchMovies(category: category))
    }
    
    func movieDetails(movieID: Int) -> AnyPublisher<Movie, APIError> {
        apiClient.request(MovieEndpoint.movieDetails(movieID: movieID))
    }
}
