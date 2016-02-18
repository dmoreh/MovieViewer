//
//  Movie.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var title: String?
    var overview: String?
    var posterPath: String? {
        didSet {
            guard let posterPath = posterPath else {
                return
            }

            let baseURL = "http://image.tmdb.org/t/p/"
            self.posterURLLowResolution = NSURL(string: baseURL + kPosterPathLowResolution + posterPath)
            self.posterURLHighResolution = NSURL(string: baseURL + kPosterPathHighResolution + posterPath)
        }
    }
    var popularity: Int?
    var posterURLHighResolution: NSURL?
    var posterURLLowResolution: NSURL?
    var releaseDate: String? {
        didSet {
            guard let releaseDate = releaseDate else {
                return
            }

            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-mm-dd"
            if let date = formatter.dateFromString(releaseDate) {
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
                self.releaseDate = formatter.stringFromDate(date)
            }

        }
    }
    var lowResPoster: UIImage?

    let kPosterPathLowResolution = "w90"
    let kPosterPathHighResolution = "original"

    convenience init(data: NSDictionary) {
        self.init()

        self.title = data["title"] as? String
        self.overview = data["overview"] as? String
        if let voteAverage = data["vote_average"] as? Float {
            let voteAveragePercentage = voteAverage * 10
            self.popularity = Int(voteAveragePercentage)
        }

        // Deferred to trigger didSet. 
        // TODO: Is this ok?
        defer {
            self.posterPath = data["poster_path"] as? String
            self.releaseDate = data["release_date"] as? String
        }
    }
}
