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
    var requestResult: Result<Data, APIError> = .failure(.requestFailed)
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError> {
        return Result.Publisher(requestResult)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                guard let apiError = error as? APIError else {
                    return APIError.decodingFailed
                }
                return apiError
            }
            .eraseToAnyPublisher()
    }
}
