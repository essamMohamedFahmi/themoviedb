//
//  MovieRepositoryTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05_themoviedb

final class MovieRepositoryTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockAPIClient: MockAPIClient<MovieEndpoint>!
    private var mockCacheManager: MockCacheManager!
    private var repository: MovieRepositoryProvider!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockAPIClient = MockAPIClient<MovieEndpoint>()
        mockCacheManager = MockCacheManager()
        repository = MovieRepositoryProvider(service: MockMovieService(apiClient: mockAPIClient), cache: mockCacheManager)
    }
    
    override func tearDown() {
        cancellables = nil
        mockAPIClient = nil
        mockCacheManager = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() throws {
        // Given
        let expectedMovieDataModel = MovieDataModel(id: 3, title: "Test Movie 1", releaseDate: "11/22/2024", posterPath: "img/test")
        
        let expectedAPIResponse = MovieList(results: [expectedMovieDataModel])
        let data = try XCTUnwrap(JSONEncoder().encode(expectedAPIResponse))
        mockAPIClient.requestResult = .success(data)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movies success")
        repository.fetchMovies(category: "popular")
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { movies in
                // Then
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Test Movie 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchMovies_shouldReturnCachedMovies_whenServiceFails() {
        // Given
        let category = "popular"
        let mockMovieDataModel = MovieDataModel(id: 3, title: "Test Movie 1", releaseDate: "11/22/2024", posterPath: "img/test")
        
        mockCacheManager.save([mockMovieDataModel], to: "movies_\(category)")
        mockAPIClient.requestResult = .failure(MovieDBError.decodingFailed)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movies from cache")
        repository.fetchMovies(category: "popular")
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { movies in
                // Then
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Test Movie 1")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchMovieDetailsSuccess() throws {
        // Given
        let mockMovieDetails = MovieDetailDataModel(id: 1, title: "Test Movie Detail", overview: "Test Overview", budget: 1, revenue: 1, runtime: 1, imdbID: "2", popularity: 1, posterPath: "img", releaseDate: "22/12")
        
        let data = try XCTUnwrap(JSONEncoder().encode(mockMovieDetails))
        mockAPIClient.requestResult = .success(data)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movie details success")
        repository.fetchMovieDetails(movieId: 1)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { movieDetails in
                // Then
                XCTAssertEqual(movieDetails.title, "Test Movie Detail")
                XCTAssertEqual(movieDetails.overview, "Test Overview")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchDetails_shouldReturnCachedDetails_whenServiceFails() {
        // Given
        let movieId = 3
        let mockMovieDetails = MovieDetailDataModel(id: 1, title: "Test Movie Detail", overview: "Test Overview", budget: 1, revenue: 1, runtime: 1, imdbID: "2", popularity: 1, posterPath: "img", releaseDate: "22/12")

        mockCacheManager.save(mockMovieDetails, to: "movie_detail_\(movieId)")
        mockAPIClient.requestResult = .failure(MovieDBError.decodingFailed)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch movie details from cache")
        repository.fetchMovieDetails(movieId: 3)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { movieDetails in
                // Then
                XCTAssertEqual(movieDetails.title, "Test Movie Detail")
                XCTAssertEqual(movieDetails.overview, "Test Overview")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
