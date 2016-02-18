//
//  Colors.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/17/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//
import UIKit
import ASCFlatUIColor

class Colors: NSObject {

    static func navigationBarColor() -> UIColor {
        return ASCFlatUIColor.nephritisColor()
    }

    static func lightTextColor() -> UIColor {
        return ASCFlatUIColor.cloudsColor()
    }

    static func darkTextColor() -> UIColor {
        return UIColor.blackColor()
    }

    static func tableViewBackroundColor() -> UIColor {
        return ASCFlatUIColor.alizarinColor()
    }

    static func cellTextColor() -> UIColor {
        return self.darkTextColor()
    }

    static func posterImageBorderColor() -> UIColor {
        return ASCFlatUIColor.cloudsColor()
    }

    static func cellSelectedColor() -> UIColor {
        return ASCFlatUIColor.pomegranateColor()
    }

}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}