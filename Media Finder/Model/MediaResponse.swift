//
//  MediaResponse.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/11/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

// MARK:- MediaType
enum MediaType: String, Codable{
    case movie = "movie"
    case music = "music"
    case tvShow = "tvShow"
    case all = "all"
}

// MARK:- MediaData
struct MediaData: Codable {
    var type: MediaType!
    var data: [Media]!
}

// MARK:- MediaResponse
struct MediaResponse: Codable {
    var resultCount: Int!
    var results: [Media]!
}

// MARK:- Media
struct Media: Codable {
    
    var artistName: String?
    var trackName: String?
    var artworkUrl: String!
    var longDescription: String?
    var previewUrl: String!
    
    enum CodingKeys: String, CodingKey {
        case artistName, trackName, longDescription, previewUrl
        case artworkUrl = "artworkUrl100"
    }
}
