//
//  FetchMovieDetailsUseCaseTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05_themoviedb

final class FetchMovieDetailsUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockAPIClient: MockAPIClient<MovieEndpoint>!
    private var mockCacheManager: MockCacheManager!
    private var useCase: FetchMovieDetailsUseCaseProvider!
    
    override func setUp() {
        super.setUp()
        
        cancellables = []
        mockAPIClient = MockAPIClient<MovieEndpoint>()
        mockCacheManager = MockCacheManager()
        useCase = FetchMovieDetailsUseCaseProvider(repository: MovieRepositoryProvider(service: MockMovieService(apiClient: mockAPIClient), cache: mockCacheManager))
    }
    
    override func tearDown() {
        cancellables = nil
        mockAPIClient = nil
        mockCacheManager = nil
        useCase = nil
        
        super.tearDown()
    }
    
    func testFetchMovieDetailsSuccess() throws {
        // Given
        let mockMovieDetails = MovieDetailDataModel(id: 1, title: "Test Movie Detail", overview: "Test Overview", budget: 1, revenue: 1, runtime: 1, imdbID: "2", popularity: 1, posterPath: "img", releaseDate: "22/12")
        
        let data = try XCTUnwrap(JSONEncoder().encode(mockMovieDetails))
        mockAPIClient.requestResult = .success(data)

        // When
        let expectation = XCTestExpectation(description: "Fetch movie details success")
        useCase.execute(movieId: 1)
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

    func testFetchMovieDetailsFailure() {
        // Given
        mockAPIClient.requestResult = .failure(MovieDBError.noCache)
        mockCacheManager.clearCache(for: "movie_detail_1")

        // When
        let expectation = XCTestExpectation(description: "Fetch movie details failure")
        useCase.execute(movieId: 1)
            .sink(receiveCompletion: { completion in
                // Then
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, MovieDBError.noCache)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got movie details")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }
}
