//
//  RestClientService.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 29/02/2024.
//

import UIKit

class RestClientService {
    static let shared = RestClientService()
    
    func fetchMovies(
        page: Int
    ) async throws -> [Movie] {
        guard
            let request = URLRequestBuilder(.movieRequest)
                .setPage(page)
                .build()
        else {
            throw RestClientServiceError.invalidRequest
        }
        do {
            let (data, _) = try await URLSession.shared.data(
                for: request
            )
            let result: MovieResponse = try self.parse(data)
            return result.results
        } catch {
            throw RestClientServiceError.networkingError
        }
    }
    
    func fetchImage(
        with path: String
    ) async throws -> UIImage? {
        guard
            let request = URLRequestBuilder(.imageRequest)
                .setImagePath(path)
                .build()
        else {
            throw RestClientServiceError.invalidRequest
        }
        do {
            let (data, _) = try await URLSession.shared.data(
                for: request
            )
            if let image = UIImage(data: data) {
                return image
            }
        } catch {
            throw RestClientServiceError.networkingError
        }
        return nil
    }
    
    private func parse<T: Decodable>(
        _ data: Data
    ) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
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
