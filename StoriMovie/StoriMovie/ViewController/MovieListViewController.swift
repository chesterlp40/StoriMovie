//
//  MovieListViewController.swift
//  StoriMovie
//
//  Created by Ezequiel Rasgido on 01/03/2024.
//

import UIKit

class MovieListViewController: UITableViewController {
    var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.viewModel.movieCount
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let movie = self.viewModel.getMovie(at: indexPath.row)
        // let images = self.viewModel.getImages(for: movie.id)
        cell.textLabel?.text = movie.title
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
    }
    
    override func tableView(
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

