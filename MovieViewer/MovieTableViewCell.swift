//
//  MovieTableViewCell.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var textContainerView: UIView!
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

            if let posterURL = movie.posterURLLowResolution {
                posterImageView.setImageWithURL(posterURL)
            } else {
                posterImageView.image = nil
            }

            // Set selected state color
            // TODO: This should go in awakeFromNib, but that uses the self.bounds from the nib.
            // It doesn't resize on larger screen sizes appropriately. What's the right way to do this?
            let selectedColorView = UIView(frame: self.bounds)
            selectedColorView.backgroundColor = Colors.cellSelectedColor()
            self.selectedBackgroundView = selectedColorView
        }
    }

    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()

        // Set text style
        self.titleLabel.textColor = Colors.cellTextColor()
        self.overviewLabel.textColor = Colors.cellTextColor()

        self.titleLabel.alpha = 0.8
        self.overviewLabel.alpha = 0.6

        self.titleLabel.font = UIFont.systemFontOfSize(18, weight: UIFontWeightMedium)
        self.overviewLabel.font = UIFont.systemFontOfSize(13, weight: UIFontWeightRegular)

        // Make posterImageView look pretty
        self.posterImageView.layer.masksToBounds = true;
        self.posterImageView.layer.borderColor = Colors.posterImageBorderColor().CGColor
        self.posterImageView.layer.borderWidth = 1
        self.posterImageView.layer.cornerRadius = 5
    }

    override func layoutSubviews() {
        // Center text vertically
        self.textContainerView.frame.size.height = self.calculateContainerHeight()

        self.textContainerView.center = CGPoint(
            x: self.textContainerView.center.x,
            y: self.posterImageView.center.y
        )
    }

    private func calculateContainerHeight() -> CGFloat {
        return self.titleLabel.frame.size.height +
            self.overviewLabel.frame.size.height
    }
}
