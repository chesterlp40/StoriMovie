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
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.title = "Top Rated Movies"
        self.view.backgroundColor = UIColor.grain200
        Helper.setNavigationConfig(
            self.navigationController
        )
        Task {
            do {
                try await self.fetchData()
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchData() async throws {
        try await self.viewModel.fetchData()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
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
            withIdentifier: MovieCell.reuseIdentifier,
            for: indexPath
        ) as! MovieCell
        let movie = self.viewModel.getMovie(
            at: indexPath.row
        )
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 140
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
                    print("Error fetching more data: \(error.localizedDescription)")
                }
            }
        }
    }
}

