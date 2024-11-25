//
//  FetchMovieDetailsUseCase.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

protocol FetchMovieDetailsUseCase {
    func execute(movieId: Int) -> AnyPublisher<MovieDetailDomainModel, APIError>
}

final class FetchMovieDetailsUseCaseProvider: FetchMovieDetailsUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(movieId: Int) -> AnyPublisher<MovieDetailDomainModel, APIError> {
        return repository.fetchMovieDetails(movieId: movieId)
    }
}
