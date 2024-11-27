//
//  MovieDetailViewModel.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Combine
import Foundation

final class MovieDetailViewModel: ObservableObject {
    // MARK: - Published Properties

    @Published var movieDetail: MovieDetail?
    @Published var errorMessage = ""
    @Published var hasError = false
    
    // MARK: - Private Properties

    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Injected Properties

    private let movieId: Int
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    
    // MARK: - Init
    
    init(movieId: Int, fetchMovieDetailsUseCase: FetchMovieDetailsUseCase) {
        self.movieId = movieId
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
    }

    // MARK: - Methods
    
    func fetchMovieDetails() {
        fetchMovieDetailsUseCase.execute(movieId: movieId)
            .map { MovieDetail(from: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.hasError = true
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] movieDetail in
                    self?.movieDetail = movieDetail
                }
            )
            .store(in: &cancellables)
    }
}
