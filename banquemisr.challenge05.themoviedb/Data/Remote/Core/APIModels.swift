//
//  APIModels.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 23/11/2024.
//

import Foundation

enum APIError: Error, Equatable {
    case requestFailed
    case decodingFailed
    case customError(statusCode: Int)
}
