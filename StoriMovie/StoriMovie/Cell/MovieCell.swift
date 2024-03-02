//
//  MovieCell.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

class MovieCell: UITableViewCell {
    static let reuseIdentifier = "MovieCell"
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    
    func configure(
        with movie: Movie
    ) {
        Task {
            do {
                self.imageMovie.image = try await RestClientService.shared.fetchImages(
                    with: movie.backdropPath
                )
            } catch {
                throw error
            }
        }
        self.titleMovieLabel.text = movie.title
        self.releaseDateMovieLabel.text = "Released:\n\(movie.releaseDate)"
        self.imageMovie.layer.cornerRadius = 5
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.grain400.cgColor
        self.layer.borderWidth = 2
    }
}
