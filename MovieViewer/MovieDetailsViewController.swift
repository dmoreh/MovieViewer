//
//  MovieDetailsViewController.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailsView: DetailsView!

    var movie: Movie?
    var placeholderImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let movie = movie else {
            return
        }

        if let posterURL = movie.posterURLLowResolution {
            backgroundImageView.setImageWithURL(posterURL)
        }

        if let posterURL = movie.posterURLHighResolution {
            backgroundImageView.setImageWithURL(posterURL)
        }

        detailsView.movie = self.movie

        let kHeightShown: CGFloat = 100
        let kPadding: CGFloat = 20

        detailsView.frame.origin.y = self.view.frame.size.height - kHeightShown
        
        scrollView.contentSize = CGSize(
            width: self.view.frame.size.width,
            height: self.view.frame.size.height + detailsView.frame.size.height - kHeightShown + kPadding
        )
    }

    override func viewWillAppear(animated: Bool) {
        if let imageColors = backgroundImageView.image?.getColors() {
            detailsView.layer.borderColor = imageColors.secondaryColor.CGColor
            detailsView.backgroundColor = imageColors.backgroundColor
            detailsView.heartImageView.tintColor = imageColors.secondaryColor

            // TODO: This line is really long. How to break it up?
            let darkColor = imageColors.backgroundColor.isDarkColor ? imageColors.backgroundColor : imageColors.secondaryColor
            let lightColor = !imageColors.backgroundColor.isDarkColor ? imageColors.backgroundColor : imageColors.secondaryColor
            self.navigationController?.navigationBar.tintColor = lightColor
            self.navigationController?.navigationBar.barTintColor = darkColor
        }
    }
}
