//
//  Media.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/11/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

struct Media: Codable {
    
    var artistName: String?
    var trackName: String?
    var artworkUrl: String!
    var longDescription: String?
    var previewUrl: String!
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case artworkUrl = "artworkUrl100"
        case longDescription
        case previewUrl
    }
}
