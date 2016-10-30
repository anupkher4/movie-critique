//
//  TmdbApi.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/27/16.
//  Copyright © 2016 AK. All rights reserved.
//

import Foundation
import Alamofire
import Result

class TmdbApi {
    
    private let dateFormatter = DateFormatter()
    private let calender = Calendar(identifier: .gregorian)
    
    func getDateComponents(fromString string: String) -> (year: Int, month: Int, day: Int)? {
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            let components = calender.dateComponents(in: TimeZone.current, from: date)
            
            return (components.year!, components.month!, components.day!)
        }
        return nil
    }
    
    // Search Movies API
    func searchForMovies(withName name: String, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let sm = SearchMovie()
        
        sm.fetchAllMovies(movieName: name, callback: { (searchResults, error) in
            if error != nil {
                completionHandler(nil, error)
            }
            
            completionHandler(searchResults, nil)
        })
    }
    
    // Movie Details API
    func getMovie(forId id: Int, completionHandler: @escaping (Movie?, Error?) -> Void) {
        let md = MovieDetail()
        
        md.getMovie(withId: id, callback: { (movie, error) in
            if error != nil {
                completionHandler(nil, error)
            }
            
            completionHandler(movie, nil)
        })
    }
    
    // Discover Movies API
    func discoverMovies(completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let dm = DiscoverMovie()
        
        dm.discoverPopularMovies(callback: { (movies, error) in
            if error != nil {
                completionHandler(nil, error)
            }
            
            completionHandler(movies, nil)
        })
    }
    
    // Find External Movie Details API
    func findExternalMovieDetails(withId id: String, completionHandler: @escaping (Movie?, Error?) -> Void) {
        let sm = SearchMovie()
        
        sm.findExternalMovieDetails(forExternalId: id, callback: { (movie, error) in
            if error != nil {
                completionHandler(nil, error)
            }
            
            completionHandler(movie, nil)
        })
    }
}
