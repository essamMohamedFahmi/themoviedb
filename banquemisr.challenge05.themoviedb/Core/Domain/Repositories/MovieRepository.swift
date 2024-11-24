//
//  MovieRepository.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

protocol MovieRepository {
    func fetchMovies(category: MovieCategory) -> AnyPublisher<[Movie], APIError>
    func fetchMovieDetails(movieId: Int) -> AnyPublisher<Movie, APIError>
}
