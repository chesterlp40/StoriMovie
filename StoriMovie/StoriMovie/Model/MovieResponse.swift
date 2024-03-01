//
//  MovieResponse.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 29/02/2024.
//

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
}
