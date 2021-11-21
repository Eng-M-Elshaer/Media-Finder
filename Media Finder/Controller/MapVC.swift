//
//  MapVC.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit
import MapKit

// MARK: - MapDelegate Protocol.
protocol MapDelegate {
    func setDelailLocationInAddress(delailsAddress: String, tag: Int)
}

class MapVC: UIViewController {
    
    // MARK: - Outlets.
    @IBOutlet weak var userLocatoinLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var delegate: MapDelegate?
    var tag = 0

    // MARK: - LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions.
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
       tapedGesture(sender)
    }
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - MapVC Methods.
extension MapVC {
    private func removeAllAnnotations() {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
    private func addAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        getNameOfLocation(lat: coordinate.latitude, long: coordinate.longitude)
    }
    private func getNameOfLocation(lat: CLLocationDegrees, long: CLLocationDegrees) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        // Geocode Location
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if error != nil {
            userLocatoinLabel.text = "Unable to Find Address for Location"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                userLocatoinLabel.text = placemark.compactAddress ?? ""
                delegate?.setDelailLocationInAddress(delailsAddress: placemark.compactAddress ?? "", tag: tag)
            } else {
                userLocatoinLabel.text = "No Matching Addresses Found"
                delegate?.setDelailLocationInAddress(delailsAddress: "No Matching Addresses Found", tag: tag )
            }
        }
    }
}

//MARK:- Private Methods.
extension MapVC {
    private func tapedGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            removeAllAnnotations()
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(coordinate: tappedCoordinate)
        }
    }
}
