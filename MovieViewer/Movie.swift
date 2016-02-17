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

            let baseURL = "http://image.tmdb.org/t/p/w500"
            self.posterURL = NSURL(string: baseURL + posterPath)
        }
    }
    var popularity: Int?
    var posterURL: NSURL?
    var releaseDate: String?

    convenience init(data: NSDictionary) {
        self.init()

        self.title = data["title"] as? String
        self.overview = data["overview"] as? String
        self.popularity = data["popularity"] as? Int
        self.releaseDate = data["release_date"] as? String
        defer { self.posterPath = data["poster_path"] as? String } // deferred to trigger didSet. Is this ok?
    }
}
