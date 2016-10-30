//
//  SearchMovies.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/27/16.
//  Copyright © 2016 AK. All rights reserved.
//

import Foundation
import Unbox

private let baseUrl = "https://api.themoviedb.org"
private let key = "0bae87a1c2bc3fd65e17a82fec52d5c7"

private enum QueryString: String {
    case api_key
    case language
    case query
    case page
    case include_adult
    case year
    case primary_release_year
    case external_source
}

class SearchMovie {
    
    private func buildSearchURL(usingKeyword keyword: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/search/movie"
        
        let apiQuery = URLQueryItem(name: QueryString.api_key.rawValue, value: key)
        let langQuery = URLQueryItem(name: QueryString.language.rawValue, value: "en-US")
        let searchQuery = URLQueryItem(name: QueryString.query.rawValue, value: keyword)
        urlComponents.queryItems = [apiQuery, langQuery, searchQuery]
        
        return urlComponents.url
    }
    
    private func buildFindUrl(usingId id: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/find/\(id)"
        
        let apiQuery = URLQueryItem(name: QueryString.api_key.rawValue, value: key)
        let langQuery = URLQueryItem(name: QueryString.language.rawValue, value: "en-US")
        let sourceQuery = URLQueryItem(name: QueryString.external_source.rawValue, value: "imdb_id")
        urlComponents.queryItems = [apiQuery, langQuery, sourceQuery]
        
        return urlComponents.url
    }
    
    func fetchAllMovies(movieName name: String, callback: @escaping ([Movie]?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        if let searchUrl = buildSearchURL(usingKeyword: name) {
            sharedSession.dataTask(with: searchUrl, completionHandler: { (data, response, error) in
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
    
    func findExternalMovieDetails(forExternalId id: String, callback: @escaping (Movie?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        if let searchUrl = buildFindUrl(usingId: id) {
            sharedSession.dataTask(with: searchUrl, completionHandler: { (data, response, error) in
                if error != nil {
                    callback(nil, error)
                }
                
                if let data = data {
                    do {
                        let json: MovieFindResults = try unbox(data: data)
                        callback(json.movie_results[0], nil)
                    } catch {
                        callback(nil, error)
                    }
                }
            }).resume()
        }
    }
    
}
