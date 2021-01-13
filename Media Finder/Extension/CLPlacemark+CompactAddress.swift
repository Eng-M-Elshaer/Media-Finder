//
//  CLPlacemark+Compact.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/9/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import MapKit

extension CLPlacemark {
    var compactAddress: String? {
        if let name = name {
            var result = name
            if let street = thoroughfare {
                result += ", \(street)"
            }
            if let city = locality {
                result += ", \(city)"
            }
            if let country = country {
                result += ", \(country)"
            }
            return result
        }
        return nil
    }
}
