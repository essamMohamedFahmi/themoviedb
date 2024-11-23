//
//  ViewModel.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Foundation
import Combine

// MARK: - DEBUG CLASS
// For testing purposes

class ViewModel: ObservableObject {
    private let movieService: MovieService
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(movieService: MovieService = MovieServiceProvider()) {
        self.movieService = movieService
    }
    
    func fetchMovies() {
        movieService.fetchMovies(category: .popular)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { movieList in
                print("PRINT::")
                print(movieList.results.first?.title)
            }
            .store(in: &cancellableSet)

    }
}
