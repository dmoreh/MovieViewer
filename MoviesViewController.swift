//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var movies: [Movie]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        APIManager.getMovies { (movies: [Movie]?) -> Void in
            self.movies = movies
        }

    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell

        let movie = self.movies![indexPath.row]

        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview

        if let posterPath = movie.posterPath {
            let baseURL = "http://image.tmdb.org/t/p/w500"
            let imageURL = NSURL(string: baseURL + posterPath)
            cell.posterImageView.setImageWithURL(imageURL!)
        } else {
            cell.posterImageView.image = nil
        }

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = self.movies else {
            return 0
        }

        return movies.count
    }
}
