//
//  Constants.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 6/10/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

// MARK: - UserDefaultsKeys.

struct UserDefaultsKeys {
    static let isLogedIn = "UDKisLogedIn"
    static let email = "UDKemail"
    static let user = "UDKuser"
}

// MARK: - StoryBoard ID.

struct StoryBoard {
    static var main = "Main"
}

// MARK: - ViewController ID.

struct ViewController {
    static let signUpVC = "SignUpVC"
    static let mapVC = "MapVC"
    static let signInVC = "SignInVC"
    static let profileVC = "ProfileVC"
    static let mediaListVC = "MediaListVC"
}

// MARK: - URL.

struct Urls {
    static let base = "https://itunes.apple.com/search?"
}

// MARK: - Parameters Keys.

struct ParameterKey {
    static let term = "term"
    static let media = "media"
}

// MARK: - SQL Keys.

struct SQL {
    
    static let usersTable = "users"
    static let mediaTable = "media"

    static let idData = "id"
    static let userData = "userData"
    static let emailData = "email"
    static let mediaHistoryData = "mediaHistory"
    static let mediaTypeData = "mediaTypeData"

}
