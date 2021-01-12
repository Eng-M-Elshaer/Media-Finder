//
//  User.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

// MARK:- Gender
enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
}

// MARK:- User
struct User: Codable {
    var image: CodableImage!
    var name: String?
    var email: String!
    var phone: String!
    var password: String!
    var gender: Gender!
    var addressOne: String!
    var addressTwo: String?
    var addressThree: String?
}

// MARK:- CodableImage
struct CodableImage: Codable {
    
    let imageData: Data?
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        return image
    }
    
    init(withImage image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0) // Not PNG
    }
}
