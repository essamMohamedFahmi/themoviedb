//
//  PresentationFactory.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import SwiftUI

class PresentationFactory {
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase

    init() {
        let movieService = MovieServiceProvider()
        let cacheManager = CacheManager()
        let movieRepository = MovieRepositoryProvider(service: movieService, cache: cacheManager)
        fetchMoviesUseCase = FetchMoviesUseCaseProvider(repository: movieRepository)
        fetchMovieDetailsUseCase = FetchMovieDetailsUseCaseProvider(repository: movieRepository)
    }
    
    func makeMovieListViewModel(for category: MovieCategory) -> MovieListViewModel {
        MovieListViewModel(category: category, fetchMoviesUseCase: fetchMoviesUseCase)
    }

    func makeMovieDetailViewModel(for movieId: Int) -> MovieDetailViewModel {
        MovieDetailViewModel(movieId: movieId, fetchMovieDetailsUseCase: fetchMovieDetailsUseCase)
    }
}
