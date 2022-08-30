//
//  CoderManger.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/15/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

class CoderManger {
    
    // MARK:- Singleton
    private static let sharedInstance = CoderManger()
    
    class func shared() -> CoderManger {
        return CoderManger.sharedInstance
    }
    
    // MARK:- Properties
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK:- Public Methods
    func encodUser(user: User) -> Data? {
        if let encoded = try? encoder.encode(user) {
            return encoded
        }
        return nil
    }
    func decodUser(userData: Data) -> User? {
        if let loadedUser = try? decoder.decode(User.self, from: userData) {
            return loadedUser
        }
        return nil
    }
    func encodMediaListData(mediaData: MediaData) -> Data? {
        if let encoded = try? encoder.encode(mediaData) {
            return encoded
        }
        return nil
    }
    func decodMediaListData(mediaListData: Data) -> MediaData? {
        if let loadedMedia = try? decoder.decode(MediaData.self, from: mediaListData) {
            return loadedMedia
        }
        return nil
    }
//    func encodMedia(media: [Media]) -> Data? {
//        if let encoded = try? encoder.encode(media) {
//            return encoded
//        }
//        return nil
//    }
//    func decodMedia(mediaData: Data) -> [Media]? {
//        if let loadedMedia = try? decoder.decode([Media].self, from: mediaData) {
//            return loadedMedia
//        }
//        return nil
//    }
}
