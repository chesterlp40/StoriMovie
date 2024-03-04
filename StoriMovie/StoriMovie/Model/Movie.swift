//
//  Movie.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 29/02/2024.
//

/// Movie model to handle data received from API.
struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Double
}
