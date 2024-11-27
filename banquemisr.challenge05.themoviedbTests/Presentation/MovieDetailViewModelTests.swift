//
//  MovieDetailViewModelTests.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 27/11/2024.
//

import XCTest
import Combine

@testable import banquemisr_challenge05_themoviedb

final class MovieDetailViewModelTests: XCTestCase {
    // MARK: Properties
    
    var viewModel: MovieDetailViewModel!
    var mockAPIClient: MockAPIClient<MovieEndpoint>!
    
    // MARK: - Setup and TearDown
    
    override func setUp() {
        super.setUp()
        
        mockAPIClient = MockAPIClient<MovieEndpoint>()
        let useCase = FetchMovieDetailsUseCaseProvider(repository: MovieRepositoryProvider(service: MockMovieService(apiClient: mockAPIClient)))
        
        viewModel = MovieDetailViewModel(movieId: 1, fetchMovieDetailsUseCase: useCase)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testFetchMovieDetailsSuccess() throws {
        // Given
        let mockMovieDetail = MovieDetailDataModel(id: 1, title: "Test Movie Detail", overview: "Test Overview", budget: 1, revenue: 1, runtime: 1, imdbID: "2", popularity: 1, posterPath: "img", releaseDate: "22/12")
        
        let data = try XCTUnwrap(JSONEncoder().encode(mockMovieDetail))
        mockAPIClient.requestResult = .success(data)
        
        // When
        viewModel.fetchMovieDetails()
        
        // Then
        let movieMapper = MovieMapper()
        let expectedMovieDetail = MovieDetail(from: movieMapper.mapToDomain(mockMovieDetail))
        
        waitUntil(viewModel.$movieDetail, equals: expectedMovieDetail)
    }
    
    func testFetchMovieDetailsFailure() throws {
        // Given
        mockAPIClient.requestResult = .failure(APIError.decodingFailed)
        
        // When
        viewModel.fetchMovieDetails()
        
        // Then
        waitUntil(viewModel.$errorMessage, equals: APIError.decodingFailed.localizedDescription)
    }
}
