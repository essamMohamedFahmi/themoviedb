//
//  MovieRepositoryProvider.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

final class MovieRepositoryProvider: MovieRepository {
    private let service: MovieService
    private let mapper = MovieMapper()

    init(service: MovieService) {
        self.service = service
    }

    func fetchMovies(category: String) -> AnyPublisher<[MovieDomainModel], APIError> {
        service.fetchMovies(category: category)
            .compactMap{ [weak self] in self?.mapper.mapToDomain($0.results) }
            .eraseToAnyPublisher()
    }

    func fetchMovieDetails(movieId: Int) -> AnyPublisher<MovieDetailDomainModel, APIError> {
        service.movieDetails(movieID: movieId)
            .compactMap{ [weak self] in self?.mapper.mapToDomain($0) }
            .eraseToAnyPublisher()
    }
}
