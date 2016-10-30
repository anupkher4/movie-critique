//
//  DiscoverMovies.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/29/16.
//  Copyright © 2016 AK. All rights reserved.
//

import Foundation
import Unbox

private let baseUrl = "https://api.themoviedb.org"
private let key = "0bae87a1c2bc3fd65e17a82fec52d5c7"

private enum QueryString: String {
    case api_key
    case language
    case sort_by
    case page
    case include_adult
    case include_video
    case year
    case primary_release_year
}

class DiscoverMovie {
    
    private func buildDiscoverUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/discover/movie"
        
        let apiQuery = URLQueryItem(name: QueryString.api_key.rawValue, value: key)
        let langQuery = URLQueryItem(name: QueryString.language.rawValue, value: "en-US")
        let sortQuery = URLQueryItem(name: QueryString.sort_by.rawValue, value: "popularity.desc")
        let adultQuery = URLQueryItem(name: QueryString.include_adult.rawValue, value: "false")
        let videoQuery = URLQueryItem(name: QueryString.include_video.rawValue, value: "true")
        let pageQuery = URLQueryItem(name: QueryString.page.rawValue, value: "1")
        urlComponents.queryItems = [apiQuery, langQuery, sortQuery, adultQuery, videoQuery, pageQuery]
        
        return urlComponents.url
    }
    
    func discoverPopularMovies(callback: @escaping ([Movie]?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        if let url = buildDiscoverUrl() {
            sharedSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    callback(nil, error)
                }
                
                if let data = data {
                    do {
                        let json: MovieSearchResults = try unbox(data: data)
                        callback(json.results, nil)
                    } catch {
                        callback(nil, error)
                    }
                }
            }).resume()
        }
    }
    
}
