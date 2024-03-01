//
//  RestClientService.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 29/02/2024.
//

import Foundation

class RestClientService {
    static let shared = RestClientService()
    
    func fetchMovies(
        page: Int
    ) async throws -> [Movie] {
        guard
            let request = URLRequestBuilder(path: "/top_rated")
                .setPage(page)
                .build()
        else {
            throw RestClientServiceError.invalidRequest
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result: MovieResponse = try self.parse(data)
            return result.results
        } catch {
            throw RestClientServiceError.networkingError
        }
    }
    
    func fetchImages(
        from id: Int
    ) async throws -> [Image] {
        let path = "/\(id.description)/images"
        guard
            let request = URLRequestBuilder(path: path)
                .build()
        else {
            throw RestClientServiceError.invalidRequest
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result: ImageResponse = try self.parse(data)
            return result.backdrops
        } catch {
            throw RestClientServiceError.networkingError
        }
    }
    
    private func parse<T: Decodable>(
        _ data: Data
    ) throws -> T {
        let decoder = JSONDecoder()
        let result = try decoder.decode(
            T.self,
            from: data
        )
        return result
    }
}

enum RestClientServiceError: Error {
    case invalidRequest
    case networkingError
}
