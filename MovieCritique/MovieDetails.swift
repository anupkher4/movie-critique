//
//  MovieDetails.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/27/16.
//  Copyright © 2016 AK. All rights reserved.
//

import Foundation
import Unbox

private let key = "0bae87a1c2bc3fd65e17a82fec52d5c7"

private enum QueryString: String {
    case api_key
    case language
    case append_to_response
}

class MovieDetail {
    
    private func buildUrlForMovie(withId id: Int) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/movie/\(id)"
        
        let apiQuery = URLQueryItem(name: QueryString.api_key.rawValue, value: key)
        let langQuery = URLQueryItem(name: QueryString.language.rawValue, value: "en-US")
        urlComponents.queryItems = [apiQuery, langQuery]
        
        return urlComponents.url
    }
    
    func getMovie(withId id: Int, callback: @escaping (Movie?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        
        if let url = buildUrlForMovie(withId: id) {
            sharedSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    callback(nil, error)
                }
                
                if let data = data {
                    do {
                        let json: Movie = try unbox(data: data)
                        callback(json, nil)
                    } catch {
                        callback(nil, error)
                    }
                }
            }).resume()
        }
    }
    
}
