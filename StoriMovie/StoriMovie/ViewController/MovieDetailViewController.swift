//
//  MovieDetailViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 02/03/2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterMovie: UIImageView!
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
        self.setupAllComponent()
    }
    
    private func setupAllComponent() {
        self.navigationItem.title = "Movie Detail View"
        self.fetchPosterAndSetImage()
        self.titleMovieLabel.text = self.movie.title
        self.overviewMovieLabel.text = self.movie.overview
        self.releaseDateMovieLabel.text = self.movie.releaseDate
        self.ratingMovieLabel.text = self.movie.voteAverage.description
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
