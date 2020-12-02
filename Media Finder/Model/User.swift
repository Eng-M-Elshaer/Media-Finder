//
//  User.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit

enum Gender: String, Codable {
    case male
    case female
}

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

struct CodableImage: Codable {
    
    let imageData: Data?
    
    init(withImage image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0) // Not PNG
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        
        return image
    }
}
