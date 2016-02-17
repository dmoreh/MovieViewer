//
//  APIManager.swift
//  MovieViewer
//
//  Created by Daniel Moreh on 2/16/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    private static let kApiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    static func getMovies(completionHandler: ([Movie]?, NSError?) -> Void) {
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(kApiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )

        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, responseOrNil, errorOrNil) in
                if let error = errorOrNil {
                    completionHandler(nil, error)
                    return
                }
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            let moviesData = responseDictionary["results"] as! [NSDictionary]
                            let movies = moviesData.map { return Movie(data: $0) }

                            completionHandler(movies, nil)
                    }
                }
        });
        task.resume()
    }
}
