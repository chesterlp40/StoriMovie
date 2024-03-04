//
//  MovieDetailViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 02/03/2024.
//

import UIKit

/// View controller to detailed expose of the movies.
class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    @IBOutlet weak var ratingMovieLabel: UILabel!
    @IBOutlet weak var ratingProgressView: CircularProgressView!
    
    private var viewModel = ImageViewModel()
    
    private var movie: Movie
    
    /// Initialize **MovieDetailViewController**.
    ///
    /// - Parameters:
    ///   - coder: **NSCoder**.
    ///   - movie: **Movie**.
    init?(
        coder: NSCoder,
        movie: Movie
    ) {
        self.movie = movie
        super.init(
            coder: coder
        )
    }
    
    /// Initialize **MovieDetailViewController**.
    ///
    /// - Parameter coder: **NSCoder**.
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    /// View configuration.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllComponents()
    }
    
    /// Setup components.
    private func setupAllComponents() {
        self.navigationItem.title = Helper.MovieDetailViewController.navigationTitleText
        self.view.backgroundColor = UIColor.grain200
        Helper.setNavigationConfig(
            self.navigationController
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: Helper.MovieDetailViewController.rightButonResourceName
            ),
            style: .plain,
            target: self,
            action: #selector(presentModal)
        )
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
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
        self.releaseDateMovieLabel.text = Helper.MovieDetailViewController.releasedDate(
            self.movie.releaseDate
        )
        self.setRating()
    }
    
    /// Formatting data to complete rating and progrees indicator.
    private func setRating() {
        var stringDouble = self.movie.voteAverage.description
        let index = stringDouble.index(stringDouble.startIndex, offsetBy: 1)
        stringDouble.remove(at: index)
        let percentSring = String(stringDouble.prefix(2))
        self.ratingMovieLabel.text = Helper.MovieDetailViewController.rated(percentSring)
        if let formattedValue = Double("0.\(stringDouble)") {
            self.ratingProgressView.animateProgress(
                to: formattedValue,
                duration: 2.0
            )
        } else {
            self.ratingProgressView.isHidden = true
        }
    }
    
    /// Request data and complete component.
    private func fetchPosterAndSetImage() {
        Task {
            do {
                self.posterMovie.image = try await self.viewModel.fetchImage(
                    with: self.movie.posterPath
                )
                self.posterMovie.contentMode = .scaleToFill
                self.activityIndicatorView.stopAnimating()
            } catch {
                self.posterMovie.image = UIImage(
                    named: Helper.wifiExclamationResource
                )
                self.posterMovie.contentMode = .scaleAspectFit
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    /// Present modal.
    @objc
    func presentModal() {
        let modalViewController = OctocadModalViewController()
        modalViewController.modalPresentationStyle = .overCurrentContext
        self.present(
            modalViewController,
            animated: true,
            completion: nil
        )
    }
}
