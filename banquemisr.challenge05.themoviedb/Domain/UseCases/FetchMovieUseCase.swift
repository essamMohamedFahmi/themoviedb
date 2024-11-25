//
//  FetchMovieUseCase.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

protocol FetchMoviesUseCase {
    func execute(category: MovieCategory) -> AnyPublisher<[MovieDomainModel], APIError>
}

final class FetchMoviesUseCaseProvider: FetchMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(category: MovieCategory) -> AnyPublisher<[MovieDomainModel], APIError> {
        return repository.fetchMovies(category: category)
    }
}
