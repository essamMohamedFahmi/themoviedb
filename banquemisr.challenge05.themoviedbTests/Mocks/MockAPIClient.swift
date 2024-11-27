//
//  MockAPIClient.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import Foundation
import Combine

@testable import banquemisr_challenge05_themoviedb

class MockAPIClient<EndpointType: APIEndpoint>: APIClient {
    var requestResult: Result<Data, MovieDBError> = .failure(.requestFailed)
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, MovieDBError> {
        return Result.Publisher(requestResult)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> MovieDBError in
                guard let apiError = error as? MovieDBError else {
                    return MovieDBError.decodingFailed
                }
                return apiError
            }
            .eraseToAnyPublisher()
    }
}
