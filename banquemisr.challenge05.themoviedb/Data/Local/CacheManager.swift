//
//  CacheManager.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 27/11/2024.
//

import Foundation

protocol CacheManagerProtocol {
    func save<T: Codable>(_ data: T, to fileName: String)
    func load<T: Codable>(from fileName: String) -> T?
    func clearCache(for fileName: String)
}

final class CacheManager: CacheManagerProtocol {
    private let fileManager: FileManager
    private let cacheDirectory: URL

    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        self.cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    func save<T: Codable>(_ data: T, to fileName: String) {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: fileURL)
        } catch {
            print("Failed to save data to cache: \(error)")
        }
    }

    func load<T: Codable>(from fileName: String) -> T? {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to load data from cache: \(error)")
            return nil
        }
    }

    func clearCache(for fileName: String) {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        try? fileManager.removeItem(at: fileURL)
    }
}
