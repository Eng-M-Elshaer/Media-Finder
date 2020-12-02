//
//  UIViewController+alert.swift
//  Media Finder
//
//  Created by AbeerSharaf on 5/19/20.
//  Copyright © 2020 Abeer. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// add alert function to the VC
    func showAlert(title: String, message: String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
