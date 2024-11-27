//
//  FetchMovieUseCaseTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05_themoviedb

final class FetchMovieUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var mockAPIClient: MockAPIClient<MovieEndpoint>!
    private var useCase: FetchMoviesUseCaseProvider!
    private var mockCacheManager: MockCacheManager!

    override func setUp() {
        super.setUp()
        
        cancellables = []
        mockAPIClient = MockAPIClient<MovieEndpoint>()
        mockCacheManager = MockCacheManager()
        useCase = FetchMoviesUseCaseProvider(repository: MovieRepositoryProvider(service: MockMovieService(apiClient: mockAPIClient), cache: mockCacheManager))
    }
    
    override func tearDown() {
        cancellables = nil
        mockAPIClient = nil
        mockCacheManager = nil
        useCase = nil
        
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
        useCase.execute(category: "popular")
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
    
    func testFetchMoviesFailure() {
        // Given
        mockAPIClient.requestResult = .failure(MovieDBError.noCache)
        mockCacheManager.clearCache(for: "movies_popular")

        // When
        let expectation = XCTestExpectation(description: "Fetch movies failure")
        useCase.execute(category: "popular")
            .sink(receiveCompletion: { completion in
                // Then
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, MovieDBError.noCache)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got movies")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
