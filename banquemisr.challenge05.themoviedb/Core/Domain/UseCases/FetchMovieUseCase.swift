//
//  FetchMovieUseCase.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

protocol FetchMoviesUseCase {
    func execute(category: MovieCategory) -> AnyPublisher<[Movie], APIError>
}

final class FetchMoviesUseCaseImpl: FetchMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        return repository.fetchMovies(category: category)
    }
}
