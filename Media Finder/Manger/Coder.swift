//
//  UIViewController+Encode.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/15/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

struct Coder {
    static func encodUser(user: User) -> Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            return encoded
        }
        return nil
    }
    static func decodUser(userData: Data) -> User? {
        let decoder = JSONDecoder()
        if let loadedUser = try? decoder.decode(User.self, from: userData) {
            return loadedUser
        }
        return nil
    }
    static func encodMedia(media: [Media]) -> Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(media) {
            return encoded
        }
        return nil
    }
    static func decodMedia(userData: Data) -> [Media]? {
        let decoder = JSONDecoder()
        if let loadedMedia = try? decoder.decode([Media].self, from: userData) {
            return loadedMedia
        }
        return nil
    }
}
