//
//  ApiConfiguration.swift
//  MovieCritique
//
//  Created by Anup Kher on 10/28/16.
//  Copyright © 2016 AK. All rights reserved.
//

import Foundation
import Unbox

struct TmdbApiConfiguration {
    let images: ImageConfiguration
    let change_keys: [String]
}

extension TmdbApiConfiguration: Unboxable {
    init(unboxer: Unboxer) throws {
        self.images = try unboxer.unbox(key: "images")
        self.change_keys = try unboxer.unbox(key: "change_keys")
    }
}

struct ImageConfiguration {
    let base_url: String
    let secure_base_url: String
    let backdrop_sizes: [String]
    let logo_sizes: [String]
    let poster_sizes: [String]
    let profile_sizes: [String]
    let still_sizes: [String]
}

extension ImageConfiguration: Unboxable {
    init(unboxer: Unboxer) throws {
        self.base_url = try unboxer.unbox(key: "base_url")
        self.secure_base_url = try unboxer.unbox(key: "secure_base_url")
        self.backdrop_sizes = try unboxer.unbox(key: "backdrop_sizes")
        self.logo_sizes = try unboxer.unbox(key: "logo_sizes")
        self.poster_sizes = try unboxer.unbox(key: "poster_sizes")
        self.profile_sizes = try unboxer.unbox(key: "profile_sizes")
        self.still_sizes = try unboxer.unbox(key: "still_sizes")
    }
}
