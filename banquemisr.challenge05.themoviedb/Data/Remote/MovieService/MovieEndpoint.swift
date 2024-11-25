//
//  MovieEndpoint.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Foundation

enum MovieEndpoint: APIEndpoint {
    case fetchMovies(category: String)
    case movieDetails(movieID: Int)
    
    var baseURL: URL {
        // TODO: - Secure your API keys properly
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case let .fetchMovies(category):
            return "/movie/\(category)"
        case let .movieDetails(movieID):
            return "/movie/\(movieID)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        // TODO: - Secure your auth token properly
        var headers: [String: String] = [:]
        headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZTc1YjUwMGJiNzc1OWU3YTYwNmJhZjAzNWVjNGFmMyIsIm5iZiI6MTczMjI0Njg4MS40Nzk0NTQ4LCJzdWIiOiI1YmQ1YjM1ODBlMGEyNjIyZDEwMmVjYTAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.mwz0IfkK3sa4eAtR6cgrhHSTqTJKDEVVVWczU3f_3Xk"
        headers["accept"] = "application/json"
        return headers
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .fetchMovies:
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        case .movieDetails:
            return [
                URLQueryItem(name: "language", value: "en-US")
            ]
        }
    }
}
