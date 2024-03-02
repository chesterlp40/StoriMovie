//
//  MovieViewModel.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

class MovieViewModel {
    private var movies: [Movie] = []
    private var currentPage = 1
    
    var movieCount: Int {
        return self.movies.count
    }
    
    func getMovie(
        at index: Int
    ) -> Movie {
        return self.movies[index]
    }
    
    func fetchData() async throws {
        do {
            let newMovies = try await RestClientService.shared.fetchMovies(
                page: self.currentPage
            )
            self.movies += newMovies
            self.currentPage += 1
        } catch {
            throw error
        }
    }
}
