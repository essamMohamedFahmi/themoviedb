//
//  MockMovieService.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import Foundation
import Combine

@testable import banquemisr_challenge05_themoviedb

class MockMovieService: MovieService {
    var apiClient: MockAPIClient<MovieEndpoint>
    
    init(apiClient: MockAPIClient<MovieEndpoint>) {
        self.apiClient = apiClient
    }

    func fetchMovies(category: String) -> AnyPublisher<MovieList, MovieDBError> {
        return apiClient.request(
            .fetchMovies(category: category)
        )
    }
    
    func movieDetails(movieID: Int) -> AnyPublisher<MovieDetailDataModel, MovieDBError> {
        return apiClient.request(
            .movieDetails(movieID: movieID)
        )
    }
}
