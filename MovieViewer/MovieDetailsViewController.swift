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

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let movie = movie else {
            return
        }

        if let posterURL = movie.posterURL {
            backgroundImageView.setImageWithURL(posterURL)
        }

        detailsView.movie = self.movie

        let kHeightShown: CGFloat = 100
        let kPadding: CGFloat = 20

        var frame = detailsView.frame
        frame.origin.y = self.view.frame.size.height - kHeightShown
        detailsView.frame = frame
        
        scrollView.contentSize = CGSize(
            width: self.view.frame.size.width,
            height: self.view.frame.size.height + detailsView.frame.size.height - kHeightShown + kPadding
        )
    }

    override func viewWillAppear(animated: Bool) {
        detailsView.layer.borderColor = backgroundImageView.image?.getColors().secondaryColor.CGColor
        detailsView.backgroundColor = backgroundImageView.image?.getColors().backgroundColor
        detailsView.alpha = 0.8
    }
}
