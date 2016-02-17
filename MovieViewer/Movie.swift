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
    var posterPath: String?
    var popularity: String?

    convenience init(data: NSDictionary) {
        self.init()

        self.title = data["title"] as? String
        self.overview = data["overview"] as? String
        self.posterPath = data["poster_path"] as? String
        self.popularity = data["popularity"] as? String
    }
}
