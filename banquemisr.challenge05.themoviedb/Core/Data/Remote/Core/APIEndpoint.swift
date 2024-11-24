//
//  APIEndpoint.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [URLQueryItem]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
}

// Extend URL functionalities to support APIEndpoint
extension URL {
    func appendingQueryParameters(_ parameters: [URLQueryItem]?) -> URL {
        guard let parameters = parameters else { return self }
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters.map { $0 }
        return components?.url ?? self
    }
}
