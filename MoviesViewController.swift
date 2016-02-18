//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var connectionErrorView: UIView!

    var movies: [Movie]? {
        didSet {
            self.filteredMovies = movies
        }
    }

    var filteredMovies: [Movie]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchMovies:", forControlEvents: .ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
        self.fetchMovies()

        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }

    func fetchMovies(refreshControl: UIRefreshControl? = nil) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        APIManager.getMovies { (movies: [Movie]?, errorOrNil: NSError?) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if let refreshControl = refreshControl {
                refreshControl.endRefreshing()
            }

            guard errorOrNil == nil else {
                self.connectionErrorView.hidden = false
                return
            }

            self.movies = movies
            self.connectionErrorView.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! MovieDetailsViewController

        let cell = sender as! MovieTableViewCell
        vc.movie = cell.movie
        vc.placeholderImage = cell.posterImageView.image
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.setSelected(false, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // TODO: This line is really long. How to break it up?
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell
        cell.movie = self.filteredMovies![indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filteredMovies = self.filteredMovies else {
            return 0
        }

        return filteredMovies.count
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        self.filteredMovies = self.movies
        searchBar.resignFirstResponder()
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        guard let movies = self.movies else {
            return
        }

        guard searchText != ""  else {
            self.filteredMovies = movies
            return
        }

        self.filteredMovies = movies.filter({ (movie: Movie) -> Bool in
            guard let title = movie.title else {
                return false
            }

            // TODO: This line is really long. How to break it up?
            guard let _ = title.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch) else {
                return false
            }

            return true
        })
    }
}
