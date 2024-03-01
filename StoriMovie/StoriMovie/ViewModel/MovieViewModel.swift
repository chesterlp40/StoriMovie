//
//  MovieViewModel.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

class MovieViewModel {
    private var movies: [Movie] = []
    private var imagesByMovieId: [Int: [Image]] = [:]
    private var currentPage = 1
    
    var movieCount: Int {
        return self.movies.count
    }
    
    func getMovie(
        at index: Int
    ) -> Movie {
        return self.movies[index]
    }
    
    func getImages(
        for movieId: Int
    ) -> [Image]? {
        return self.imagesByMovieId[movieId]
    }
    
    func fetchData() async throws {
        do {
            let newMovies = try await RestClientService.shared.fetchMovies(
                page: self.currentPage
            )
            self.movies += newMovies
            self.currentPage += 1
            for movie in newMovies {
                let images = try await RestClientService.shared.fetchImages(
                    from: movie.id
                )
                self.imagesByMovieId[movie.id] = images
            }
        } catch {
            throw error
        }
    }
}
