//
//  Constants.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 6/10/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

// MARK:- UserDefaultsKeys.
struct UserDefaultsKeys {
    static let isLogedIn = "UDKisLogedIn"
    static let email = "UDKemail"
    static let isOpenedBefore = "UDKisOpenedBefore"
}

// MARK:- Storyboard.
struct StoryBoard {
    static var main = "Main"
}

// MARK:- ViewController.
struct ViewController {
    static let signUpVC = "SignUpVC"
    static let mapVC = "MapVC"
    static let signInVC = "SignInVC"
    static let profileVC = "ProfileVC"
    static let mediaListVC = "MediaListVC"
    static let mapCenterVC = "MapCenterVC"
    static let mapWithCurrentLocationVC = "MapWithCurrentLocationVC"
    static let mapScreenVC = "MapScreenVC"
}

// MARK:- URL.
struct Urls {
    static let base = "https://itunes.apple.com/search?"
}

// MARK:- Parameters Keys.
struct ParameterKey {
    static let term = "term"
    static let media = "media"
}

// MARK:- SQL Keys.
struct SQL {
    static let usersTable = "users"
    static let idData = "id"
    static let userData = "userData"
    static let mediaListData = "mediaListData"
//    static let mediaTable = "media"
//    static let emailData = "email"
//    static let mediaTypeData = "mediaTypeData"
}

// MARK:- Cells.
struct CustomCell {
    static let mediaCell = "MediaCell"
}

// MARK:- Images.
struct Images {
    static let user = "user"
    static let placeholder = "placeholder.png"
    static let noRecord = "Search.png"
}

// MARK:- AlertTitle.
struct AlertTitle {
    static let sorry = "Sorry"
    static let success = "Success"
}

// MARK:- AlertMessage.
struct AlertMessage {
    static let choosePhoto = "Please Choose Photo"
    static let enterEmail = "Please Enter Email"
    static let enterPassword = "Please Enter Password"
    static let enterPhone = "Please Enter Phone"
    static let enterAddress = "Please Enter Address"
    static let vaildEmail = "Enter Vaild Email \n Example: exmaple@email.com"
    static let vaildPassword = "Please Enter Vaild Password \n need to be: \n at least one uppercase \n at least one digit \n at least one lowercase \n 8 characters total"
    static let vaildPhone = "Enter Vaild Phone Number: \n Example: 01000000000"
    static let invalidEmailOrPassword = "Invalid Email Or Password"
    static let enterData = "Please Enter Meida Name First"
    static let dataNeed = "Data Need To Be 3 Or More Letters"
    static let createdSuccessfully = "Your Account Has Been Created Successfully"
}

// MARK:- ViewControllerTitle.
struct ViewControllerTitle {
    static let profile = "Profile"
    static let mediaList = "Media List"
    static let signIn = "Sign In"
    static let signUp = "Sign Up"
}
