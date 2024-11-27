//
//  MovieRepositoryProvider.swift
//  banquemisr.challenge05.themoviedb
//
//  Created by essamfahmy on 24/11/2024.
//

import Combine

final class MovieRepositoryProvider: MovieRepository {
    private let mapper = MovieMapper()
    private let service: MovieService
    private let cache: CacheManagerProtocol
    
    init(service: MovieService, cache: CacheManagerProtocol) {
        self.service = service
        self.cache = cache
    }
    
    func fetchMovies(category: String) -> AnyPublisher<[MovieDomainModel], MovieDBError> {
        let cacheKey = "movies_\(category)"
        return service.fetchMovies(category: category)
            .map { [weak self] movieList in
                self?.cache.save(movieList.results, to: cacheKey)
                return movieList.results
            }
            .compactMap { [weak self] in
                self?.mapper.mapToDomain($0)
            }
            .catch { [weak self] _ -> AnyPublisher<[MovieDomainModel], MovieDBError> in
                guard let self = self else {
                    return Empty().eraseToAnyPublisher()
                }
                
                guard let cachedMovies: [MovieDataModel] = cache.load(from: cacheKey) else {
                    return Fail(error: MovieDBError.noCache).eraseToAnyPublisher()
                }
                
                return Just(mapper.mapToDomain(cachedMovies))
                    .setFailureType(to: MovieDBError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMovieDetails(movieId: Int) -> AnyPublisher<MovieDetailDomainModel, MovieDBError> {
        let cacheKey = "movie_detail_\(movieId)"
        return service.movieDetails(movieID: movieId)
            .map { [weak self] movieDetail in
                guard let self = self else { return movieDetail }
                cache.save(movieDetail, to: cacheKey)
                return movieDetail
            }
            .compactMap { [weak self] in
                self?.mapper.mapToDomain($0)
            }
            .catch { [weak self] _ -> AnyPublisher<MovieDetailDomainModel, MovieDBError> in
                guard let self = self else {
                    return Empty().eraseToAnyPublisher()
                }
                
                guard let cachedDetail: MovieDetailDataModel = cache.load(from: cacheKey) else {
                    return Fail(error: MovieDBError.noCache).eraseToAnyPublisher()
                }
                
                return Just(mapper.mapToDomain(cachedDetail))
                    .setFailureType(to: MovieDBError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
