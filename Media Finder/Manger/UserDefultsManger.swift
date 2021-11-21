//
//  UserDefultsManger.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

class UserDefultsManger {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefultsManger()
    
    class func shared() -> UserDefultsManger {
        return UserDefultsManger.sharedInstance
    }
    
    // MARK:- Properties
    private let defaults = UserDefaults.standard
    
    var isLogedIn: Bool {
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.isLogedIn )
        }
        get {
            guard defaults.object(forKey: UserDefaultsKeys.isLogedIn ) != nil else {
                return false
            }
            return defaults.bool(forKey: UserDefaultsKeys.isLogedIn )
        }
    }
    var isOpenedBefore: Bool {
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.isOpenedBefore )
        }
        get {
            guard defaults.object(forKey: UserDefaultsKeys.isOpenedBefore ) != nil else {
                return false
            }
            return defaults.bool(forKey: UserDefaultsKeys.isOpenedBefore )
        }
    }
    var email: String {
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.email )
        }
        get {
            guard defaults.object(forKey: UserDefaultsKeys.email ) != nil else {
                return "N/A"
            }
            return defaults.string(forKey: UserDefaultsKeys.email )!
        }
    }
}
