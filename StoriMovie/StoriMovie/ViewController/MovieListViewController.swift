//
//  MovieListViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllComponents()
    }
    
    private func setupAllComponents() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(handleRefresh(_:)),
            for: .valueChanged
        )
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.refreshControl = refreshControl
        self.navigationItem.title = "Top Rated Movies"
        self.view.backgroundColor = UIColor.grain200
        Helper.setNavigationConfig(
            self.navigationController
        )
        Task {
            do {
                try await self.fetchData()
            } catch {
                self.tableView.backgroundView = self.setupErrorView()
            }
        }
    }
    
    @objc 
    func handleRefresh(
        _ refreshControl: UIRefreshControl
    ) {
        refreshControl.beginRefreshing()
        Task {
            do {
                try await self.fetchData()
            } catch {
                self.tableView.backgroundView = self.setupErrorView()
            }
        }
        refreshControl.endRefreshing()
    }
    
    func fetchData() async throws {
        try await self.viewModel.fetchData()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        if self.viewModel.movieCount == 0 {
            self.tableView.backgroundView = self.setupErrorView()
        }
    }
    
    func setupErrorView() -> UIView {
        let errorView = UIView(
            frame: self.tableView.bounds
        )

        let errorImageView = UIImageView(
            image: UIImage(named: "wifi.exclamation")
        )
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: 120,
            height: 120
        )
        errorImageView.center = errorView.center
        errorView.addSubview(errorImageView)
        return errorView
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.viewModel.movieCount
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Helper.MovieCell.reuseIdentifier,
            for: indexPath
        ) as! MovieCell
        let movie = self.viewModel.getMovie(
            at: indexPath.row
        )
        DispatchQueue.main.async {
            cell.configure(
                with: movie
            )
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 130
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let movie = self.viewModel.getMovie(
            at: indexPath.row
        )
        let bundle = Bundle(for: MovieDetailViewController.self)
        let storyboard = UIStoryboard(
            name: "Main",
            bundle: bundle
        )
        let movieDetailViewController = storyboard.instantiateViewController(identifier: "MovieDetailViewController") { coder in
            MovieDetailViewController(coder: coder, movie: movie)
        }
        self.navigationController?.pushViewController(
            movieDetailViewController,
            animated: true
        )
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.row == self.viewModel.movieCount - 1 {
            Task {
                do {
                    try await self.fetchData()
                } catch {
                    self.tableView.backgroundView = self.setupErrorView()
                }
            }
        }
    }
}
