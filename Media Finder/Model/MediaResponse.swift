//
//  MediaResponse.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/11/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

// MARK:- MediaType
enum MediaType: String {
    case movie = "movie"
    case music = "music"
    case tvShow = "tvShow"
    case all = "all"
}

// MARK:- MediaResponse
struct MediaResponse: Codable {
    var resultCount: Int!
    var results: [Media]!
}
