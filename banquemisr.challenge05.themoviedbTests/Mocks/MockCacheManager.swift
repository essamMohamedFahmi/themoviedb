//
//  MockCacheManager.swift
//  banquemisr.challenge05.themoviedbTests
//
//  Created by essamfahmy on 27/11/2024.
//

import Foundation

@testable import banquemisr_challenge05_themoviedb

final class MockCacheManager: CacheManagerProtocol {
    private var inMemoryCache: [String: Data] = [:]

    // Save data to an in-memory dictionary instead of the file system
    func save<T: Codable>(_ data: T, to fileName: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            inMemoryCache[fileName] = encodedData
        } catch {
            print("Mock: Failed to encode and save data to cache: \(error)")
        }
    }

    // Load data from the in-memory dictionary instead of the file system
    func load<T: Codable>(from fileName: String) -> T? {
        guard let cachedData = inMemoryCache[fileName] else {
            return nil
        }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: cachedData)
            return decodedData
        } catch {
            print("Mock: Failed to decode data from cache: \(error)")
            return nil
        }
    }

    // Clear cache by removing the entry from the in-memory dictionary
    func clearCache(for fileName: String) {
        inMemoryCache.removeValue(forKey: fileName)
    }
}

