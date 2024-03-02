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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    
    func configure(
        with movie: Movie
    ) {
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
        Task {
            do {
                self.imageMovie.image = try await RestClientService.shared.fetchImages(
                    with: movie.backdropPath
                )
                self.activityIndicatorView.stopAnimating()
            } catch {
                self.imageMovie.image = UIImage(named: "wifi.exclamation")
                self.activityIndicatorView.stopAnimating()
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
