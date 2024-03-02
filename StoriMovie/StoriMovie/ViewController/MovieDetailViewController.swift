//
//  MovieDetailViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 02/03/2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    @IBOutlet weak var ratingMovieLabel: UILabel!
    
    private var movie: Movie
    
    init?(
        coder: NSCoder,
        movie: Movie
    ) {
        self.movie = movie
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllComponents()
    }
    
    private func setupAllComponents() {
        self.navigationItem.title = "Movie Detail View"
        self.view.backgroundColor = UIColor.grain200
        Helper.setNavigationConfig(
            self.navigationController
        )
        self.fetchPosterAndSetImage()
        self.posterMovie.layer.cornerRadius = 5
        self.posterMovie.layer.borderColor = UIColor.grain400.cgColor
        self.posterMovie.layer.borderWidth = 2
        self.posterMovie.contentMode = .scaleToFill
        self.posterMovie.clipsToBounds = true
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderColor = UIColor.grain500.cgColor
        self.contentView.layer.borderWidth = 2
        self.titleMovieLabel.text = self.movie.title
        self.overviewMovieLabel.text = self.movie.overview
        self.releaseDateMovieLabel.text = "Released: \(self.movie.releaseDate)"
        self.ratingMovieLabel.text = "Rated: \(self.movie.voteAverage.description)"
    }
    
    private func fetchPosterAndSetImage() {
        Task {
            do {
                self.posterMovie.image = try await RestClientService.shared.fetchImages(
                    with: self.movie.posterPath
                )
            } catch {
                throw error
            }
        }
    }
}
