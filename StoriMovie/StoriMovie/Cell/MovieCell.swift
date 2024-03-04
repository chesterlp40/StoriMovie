//
//  MovieCell.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

/// Custom **UITableViewCell**.
final class MovieCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    
    private var viewModel = ImageViewModel()
    
    /// Configure all components in cell.
    ///
    /// - Parameter movie: **Movie**.
    func configure(
        with movie: Movie
    ) {
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
        Task {
            do {
                self.imageMovie.image = try await self.viewModel.fetchImage(
                    with: movie.backdropPath
                )
                self.activityIndicatorView.stopAnimating()
            } catch {
                self.imageMovie.image = UIImage(
                    named: Helper.wifiExclamationResource
                )
                self.imageMovie.contentMode = .scaleAspectFit
                self.activityIndicatorView.stopAnimating()
            }
        }
        self.titleMovieLabel.text = movie.title
        self.releaseDateMovieLabel.text = Helper.MovieCell.releasedDate(
            movie.releaseDate
        )
        self.imageMovie.layer.cornerRadius = 5
        self.layer.backgroundColor = UIColor(named: "Grain300")?.cgColor
        self.containerView.layer.backgroundColor = UIColor(named: "Grain100")?.cgColor
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor(named: "Grain400")?.cgColor
        self.containerView.layer.borderWidth = 2
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4)
        ])
    }
}
