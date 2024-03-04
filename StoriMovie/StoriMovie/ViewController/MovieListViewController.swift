//
//  MovieListViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

/// View controller for show all the top rated movies with image and information.
final class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var viewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    /// View configuration.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllComponents()
    }
    
    /// Setup components.
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
        self.navigationItem.title = Helper.MovieListViewController.navigationTitleText
        self.view.backgroundColor = UIColor(named: "Grain200")
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
    
    /// Handle pull to refresh feature.
    ///
    /// - Parameter refreshControl: **UIRefreshControl**.
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
    
    /// Request data.
    func fetchData() async throws {
        try await self.viewModel.fetchData()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        if self.viewModel.movieCount == 0 {
            self.tableView.backgroundView = self.setupErrorView()
        }
    }
    
    /// Configure Error View.
    ///
    /// - Returns: **UIView**.
    func setupErrorView() -> UIView {
        let errorView = UIView(
            frame: self.tableView.bounds
        )

        let errorImageView = UIImageView(
            image: UIImage(
                named: Helper.wifiExclamationResource
            )
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
    
    /// Numbers of rows in section.
    ///
    /// - Parameters:
    ///   - tableView: **UITableView**.
    ///   - section: **Int**.
    /// - Returns: **Int**.
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.viewModel.movieCount
    }
    
    /// Cell for row at index path.
    ///
    /// - Parameters:
    ///   - tableView: **UITableView**.
    ///   - indexPath: **IndexPath**.
    /// - Returns: **UITableViewCell**.
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
    
    /// Height for row at index path.
    ///
    /// - Parameters:
    ///   - tableView: **UITableView**.
    ///   - indexPath: **IndexPath**.
    /// - Returns: **CGFloat**.
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 130
    }
    
    /// Did select row at index path.
    ///
    /// - Parameters:
    ///   - tableView: **UITableView**.
    ///   - indexPath: **IndexPath**.
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let movie = self.viewModel.getMovie(
            at: indexPath.row
        )
        let bundle = Bundle(for: MovieDetailViewController.self)
        let storyboard = UIStoryboard(
            name: Helper.MovieListViewController.storyboardName,
            bundle: bundle
        )
        let movieDetailViewController = storyboard.instantiateViewController(
            identifier: Helper.MovieListViewController.detailViewControllerIdentifier
        ) { coder in
            MovieDetailViewController(
                coder: coder,
                movie: movie
            )
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
    
    /// Will display cell for row at index path.
    ///
    /// - Parameters:
    ///   - tableView: **UITableView**.
    ///   - cell: **UITableViewCell**.
    ///   - indexPath: **IndexPath**.
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
