//
//  String+Trimed.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation

extension String {
    /// add trimmed with whitespacesAndNewlines to string
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
