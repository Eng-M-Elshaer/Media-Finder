//
//  UIView+Loader.swift
//  IUMAK-iOS
//
//  Created by Mustafa on 12/7/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

extension UIView {
	func showLoader() {
		let activityIndicator = setupActivityIndicator()
		activityIndicator.startAnimating()
		self.addSubview(activityIndicator)
	}
	func hideLoader() {
		if let activityIndicator = viewWithTag(333) {
			activityIndicator.removeFromSuperview()
		}
	}
	private func setupActivityIndicator() -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView()
		activityIndicator.frame = self.bounds
		activityIndicator.center = self.center
		activityIndicator.style = .gray
		activityIndicator.tag = 333
		return activityIndicator
	}
}
