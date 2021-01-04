//
//  Manger.swift
//  Authentication Module
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
    
    var isLogedIn: Bool  {
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
    var email: String  {
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
    func setUserDefaults(user: User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: "User" )
        }
    }
    func getUserDefaults() -> User? {
        if let savedUser = UserDefaults.standard.object(forKey: "User" ) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                print(loadedUser.name ?? "N/A")
                return loadedUser
            }
        }
        return nil
    }
}
