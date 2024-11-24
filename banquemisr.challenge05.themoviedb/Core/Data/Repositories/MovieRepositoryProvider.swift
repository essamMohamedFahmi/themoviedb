//
//  MovieRepositoryProvider.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

final class MovieRepositoryProvider: MovieRepository {
    private let service: MovieService

    init(service: MovieService) {
        self.service = service
    }

    func fetchMovies(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        service.fetchMovies(category: category)
            .map { $0.results }
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(movieId: Int) -> AnyPublisher<Movie, APIError> {
        service.movieDetails(movieID: movieId)
            .eraseToAnyPublisher()
    }
}
