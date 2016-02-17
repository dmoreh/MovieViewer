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
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        APIManager.getMovies { (movies: [Movie]?, errorOrNil: NSError?) -> Void in
            if let error = errorOrNil {
                print(error)
                self.connectionErrorView.hidden = false
                MBProgressHUD.hideHUDForView(self.view, animated: true)

                return
            }

            self.movies = movies

            self.connectionErrorView.hidden = true
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! MovieDetailsViewController
        let cell = sender as! MovieTableViewCell
        vc.movie = cell.movie
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
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieTableViewCell
        cell.movie = self.movies![indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = self.movies else {
            return 0
        }

        return movies.count
    }
}
