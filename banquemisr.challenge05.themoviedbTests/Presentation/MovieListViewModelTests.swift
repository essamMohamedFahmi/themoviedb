//
//  MovieListViewModelTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 27/11/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05_themoviedb

final class MovieListViewModelTests: XCTestCase {
    // MARK: Properties
    
    private var viewModel: MovieListViewModel!
    private var mockAPIClient: MockAPIClient<MovieEndpoint>!
    private var mockCacheManager: MockCacheManager!

    // MARK: - Setup and TearDown
    
    override func setUp() {
        super.setUp()
        
        mockAPIClient = MockAPIClient<MovieEndpoint>()
        mockCacheManager = MockCacheManager()
        let useCase = FetchMoviesUseCaseProvider(repository: MovieRepositoryProvider(service: MockMovieService(apiClient: mockAPIClient), cache: mockCacheManager))
        
        viewModel = MovieListViewModel(category: .nowPlaying, fetchMoviesUseCase: useCase)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        mockCacheManager = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testFetchMoviesSuccess() throws {
        // Given
        let expectedMovieDataModel = MovieDataModel(
            id: 3,
            title: "Test Movie 1",
            releaseDate: "2024-11-22",
            posterPath: "img/test"
        )
        
        let expectedAPIResponse = MovieList(results: [expectedMovieDataModel])
        let data = try XCTUnwrap(JSONEncoder().encode(expectedAPIResponse))
        mockAPIClient.requestResult = .success(data)
        
        // When
        viewModel.fetchMovies()
        
        // Then
        let movieMapper = MovieMapper()
        let expectedMovies = movieMapper.mapToDomain([expectedMovieDataModel]).map{ Movie(from: $0) }
        
        waitUntil(viewModel.$movies, equals: expectedMovies)
    }
    
    func testFetchMoviesFailure() throws {
        // Given
        mockAPIClient.requestResult = .failure(MovieDBError.noCache)
        mockCacheManager.clearCache(for: "movies_now_playing")
        
        // When
        viewModel.fetchMovies()
        
        // Then
        waitUntil(viewModel.$errorMessage, equals: MovieDBError.noCache.localizedDescription)
    }
}
