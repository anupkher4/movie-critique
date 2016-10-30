//
//  Movie.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/27/16.
//  Copyright © 2016 AK. All rights reserved.
//

import Foundation
import Unbox

struct Movie {
    let adult: Bool
    let backdrop_path: String?
    let budget: Int?
    let genres: [MovieGenre]?
    let genre_ids: [Int]?
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let release_date: String
    let revenue: Int?
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

extension Movie: Unboxable {
    init(unboxer: Unboxer) throws {
        self.adult = try unboxer.unbox(key: "adult")
        self.backdrop_path = unboxer.unbox(key: "backdrop_path")
        self.budget = unboxer.unbox(key: "budget")
        self.genres = unboxer.unbox(key: "genres")
        self.genre_ids = unboxer.unbox(key: "genre_ids")
        self.homepage = unboxer.unbox(key: "homepage")
        self.id = try unboxer.unbox(key: "id")
        self.imdb_id = unboxer.unbox(key: "imdb_id")
        self.original_language = try unboxer.unbox(key: "original_language")
        self.original_title = try unboxer.unbox(key: "original_title")
        self.overview = try unboxer.unbox(key: "overview")
        self.popularity = try unboxer.unbox(key: "popularity")
        self.poster_path = unboxer.unbox(key: "poster_path")
        self.production_companies = unboxer.unbox(key: "production_companies")
        self.production_countries = unboxer.unbox(key: "production_countries")
        self.release_date = try unboxer.unbox(key: "release_date")
        self.revenue = unboxer.unbox(key: "revenue")
        self.runtime = unboxer.unbox(key: "runtime")
        self.spoken_languages = unboxer.unbox(key: "spoken_languages")
        self.status = unboxer.unbox(key: "status")
        self.tagline = unboxer.unbox(key: "tagline")
        self.title = try unboxer.unbox(key: "title")
        self.video = try unboxer.unbox(key: "video")
        self.vote_average = try unboxer.unbox(key: "vote_average")
        self.vote_count = try unboxer.unbox(key: "vote_count")
    }
}

extension Movie: Equatable, Comparable {
    
    public static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.popularity == rhs.popularity
    }
    
    public static func <(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.popularity < rhs.popularity
    }
    
    public static func <=(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.popularity <= rhs.popularity
    }
    
    public static func >=(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.popularity >= rhs.popularity
    }
    
    public static func >(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.popularity > rhs.popularity
    }
}

struct MovieGenre {
    let id: Int
    let name: String
}

extension MovieGenre: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
    }
}

struct ProductionCompany {
    let name: String
    let id: Int
}

extension ProductionCompany: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
    }
}

struct ProductionCountry {
    let iso_3166_1: String
    let name: String
}

extension ProductionCountry: Unboxable {
    init(unboxer: Unboxer) throws {
        self.iso_3166_1 = try unboxer.unbox(key: "iso_3166_1")
        self.name = try unboxer.unbox(key: "name")
    }
}

struct SpokenLanguage {
    let iso_639_1: String
    let name: String
}

extension SpokenLanguage: Unboxable {
    init(unboxer: Unboxer) throws {
        self.iso_639_1 = try unboxer.unbox(key: "iso_639_1")
        self.name = try unboxer.unbox(key: "name")
    }
}

struct MovieSearchResults {
    let page: Int
    let results: [Movie]
    let total_results: Int
    let total_pages: Int
}

extension MovieSearchResults: Unboxable {
    init(unboxer: Unboxer) throws {
        self.page = try unboxer.unbox(key: "page")
        self.results = try unboxer.unbox(key: "results")
        self.total_results = try unboxer.unbox(key: "total_results")
        self.total_pages = try unboxer.unbox(key: "total_pages")
    }
}

struct MovieFindResults {
    let movie_results: [Movie]
//    let person_results: []
//    let tv_results: []
//    let tv_episode_results: []
//    let tv_season_results: []
}

extension MovieFindResults: Unboxable {
    init(unboxer: Unboxer) throws {
        self.movie_results = try unboxer.unbox(key: "movie_results")
    }
}
