//
//  MovieTableViewCell.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }

            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            overviewLabel.sizeToFit()

            if let posterURL = movie.posterURL {
                posterImageView.setImageWithURL(posterURL)
            } else {
                posterImageView.image = nil
            }
        }
    }
}
