//
//  APIClientTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05_themoviedb

final class APIClientTests: XCTestCase {
    // MARK: Properties
    
    var apiClient: URLSessionAPIClient<MovieEndpoint>!

    // MARK: - Setup and TearDown
    
    override func setUp() {
        super.setUp()
        apiClient = URLSessionAPIClient<MovieEndpoint>(session: MockURLSession())
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testRequestSuccess() throws {
        // Given
        let expectedMovieDataModel = MovieDataModel(id: 3, title: "Test", releaseDate: "11/22/2024", posterPath: "img/test")
        
        let expectedAPIResponse = MovieList(results: [expectedMovieDataModel])
        let data = try XCTUnwrap(JSONEncoder().encode(expectedAPIResponse))
        let expectation = XCTestExpectation(description: "Request done successfully!")
          
        MockURLProtocol.resetMockData()
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        _ = apiClient.request(.fetchMovies(category: "popular"))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { (response: MovieList) in
                // Then
                XCTAssertEqual(response.results.count, 1)
                XCTAssertEqual(response.results[0], expectedMovieDataModel)
                expectation.fulfill()
            })
        
        // Complete the expectation
        wait(for: [expectation], timeout: 2)
    }
    
    func testRequestSuccessForMovieDetail() throws {
        // Given
        let expectedMovieDetailDataModel = MovieDetailDataModel(id: 1, title: "Test Movie Detail", overview: "Test Overview", budget: 1, revenue: 1, runtime: 1, imdbID: "2", popularity: 1, posterPath: "img", releaseDate: "22/12")
                
        let data = try XCTUnwrap(JSONEncoder().encode(expectedMovieDetailDataModel))
        let expectation = XCTestExpectation(description: "Request done successfully!")
          
        MockURLProtocol.resetMockData()
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // When
        _ = apiClient.request(.movieDetails(movieID: 1))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    XCTFail("Unexpected failure: \(error)")
                }
            }, receiveValue: { (response: MovieDetailDataModel) in
                // Then
                XCTAssertEqual(response, expectedMovieDetailDataModel)
                expectation.fulfill()
            })
        
        // Complete the expectation
        wait(for: [expectation], timeout: 2)
    }
    
    func testRequestFailureCustomError() throws {
        // Given
        let expectation = XCTestExpectation(description: "Request failed!")
        MockURLProtocol.resetMockData()
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!, statusCode: 422, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // When
        _ = apiClient.request(.movieDetails(movieID: 1))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected success")
                case let .failure(error):
                    // Then
                    XCTAssertEqual(error, MovieDBError.customError(statusCode: 422))
                    expectation.fulfill()
                }
            }, receiveValue: { (response: MovieDetailDataModel) in
                XCTFail("Unexpected response \(response.id)")
            })
        
        // Complete the expectation
        wait(for: [expectation], timeout: 2)
    }
    
    func testRequestFailureDecodingFailed() throws {
        // Given
        let expectation = XCTestExpectation(description: "Request failed!")
        MockURLProtocol.resetMockData()
        MockURLProtocol.populateRequestHandler()
        MockURLProtocol.decodingFailed = true

        // When
        _ = apiClient.request(.movieDetails(movieID: 1))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected success")
                case let .failure(error):
                    // Then
                    XCTAssertEqual(error, MovieDBError.decodingFailed)
                    expectation.fulfill()
                }
            }, receiveValue: { (response: MovieDetailDataModel) in
                XCTFail("Unexpected response \(response.id)")
            })
        
        // Complete the expectation
        wait(for: [expectation], timeout: 2)
    }
    
    func testRequestFailureRequestFailed() throws {
        // Given
        let expectation = XCTestExpectation(description: "Request failed!")
        MockURLProtocol.resetMockData()
        MockURLProtocol.populateRequestHandler()
        MockURLProtocol.requestFailed = true

        // When
        _ = apiClient.request(.movieDetails(movieID: 1))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Unexpected success")
                case let .failure(error):
                    // Then
                    XCTAssertEqual(error, MovieDBError.requestFailed)
                    expectation.fulfill()
                }
            }, receiveValue: { (response: MovieDetailDataModel) in
                XCTFail("Unexpected response \(response.id)")
            })
        
        // Complete the expectation
        wait(for: [expectation], timeout: 2)
    }
}
