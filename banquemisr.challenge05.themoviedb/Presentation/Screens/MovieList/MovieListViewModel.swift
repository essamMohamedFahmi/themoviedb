//
//  MoviesViewModel.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 25/11/2024.
//

import Combine
import Foundation

final class MovieListViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var movies: [Movie] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    @Published var isLoading = false
    
    // MARK: - Private Properties
    
    private let category: MovieCategory
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    
    init(category: MovieCategory, fetchMoviesUseCase: FetchMoviesUseCase) {
        self.category = category
        self.fetchMoviesUseCase = fetchMoviesUseCase
    }
    
    // MARK: - Methods

    func fetchMovies() {
        isLoading = true
        fetchMoviesUseCase.execute(category: category)
            .map { movies in
                movies.map { Movie(from: $0) }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.hasError = true
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
}
