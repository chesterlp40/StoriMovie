//
//  Image.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

struct Image: Codable {
    let aspectRatio: Float
    let height: Int
    let iso6391: String?
    let filePath: String
    let voteAverage: Float
    let voteCount: Int
    let width: Int
}
