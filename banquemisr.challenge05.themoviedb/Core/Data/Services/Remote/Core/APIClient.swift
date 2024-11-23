//
//  APIClient.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Combine
import Foundation

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError>
}

protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    private var session: URLSessionProtocol

    // MARK: - Init

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    // MARK: - Request

    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, APIError>
    {
        let url = endpoint.baseURL
            .appendingPathComponent(endpoint.path)
            .appendingQueryParameters(endpoint.queryParameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        print(request)

        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.requestFailed
                }

                guard (200 ... 299).contains(httpResponse.statusCode) else {
                    throw APIError.customError(statusCode: httpResponse.statusCode)
                }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> APIError in
                guard let error = error as? APIError else {
                    return APIError.decodingFailed
                }
                return error
            })
            .eraseToAnyPublisher()
    }
}
