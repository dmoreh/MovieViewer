//
//  DetailsView.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 5 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }

            titleLabel.text = movie.title
            titleLabel.sizeToFit()
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            overviewLabel.sizeToFit()

            if let popularity = movie.popularity {
                popularityLabel.text = "\(popularity)%"
            }

            self.layoutIfNeeded()
        }
    }

    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.alpha = 0.8
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.frame.size.height = self.calculateHeight()

        // TODO: Interested in what instructors think of this.
        for label in [titleLabel, releaseDateLabel, overviewLabel, popularityLabel] {
            if let backgroundColor = self.backgroundColor {
                label.textColor = backgroundColor.isDarkColor ? Colors.lightTextColor() : Colors.darkTextColor()
            }
        }
    }

    private func calculateHeight() -> CGFloat {
        let kPadding: CGFloat = 8
        return kPadding + titleLabel.frame.size.height
            + kPadding + popularityLabel.frame.size.height
            + kPadding + overviewLabel.frame.size.height
            + kPadding
    }
}
