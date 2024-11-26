//
//  MockURLSession.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 26/11/2024.
//

import Combine
import Foundation

@testable import banquemisr_challenge05_themoviedb

class MockURLSession: URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        return URLSession.DataTaskPublisher(request: request, session: session)
    }
}
