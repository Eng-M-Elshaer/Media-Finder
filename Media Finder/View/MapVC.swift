//
//  MapVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 5/25/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit
import MapKit

protocol MapDelegate {
    func setDelailLocationInAddress(delailsAddress: String,tag:Int)
}

class MapVC: UIViewController {
    
    @IBOutlet weak var userLocatoinLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //variables
    var delegate: MapDelegate?
    let locationManager = CLLocationManager()
    let regionMeters: Double = 10000
    var previousLocation:CLLocation?
    lazy var geocoder = CLGeocoder()
    var tag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            removeAllAnnotations()
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(coordinate: tappedCoordinate)
        }
    }

    @IBAction func submitBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapVC {
    
    private func removeAllAnnotations() {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
    
    private func addAnnotation(coordinate:CLLocationCoordinate2D) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        getNameOfLocation(lat: coordinate.latitude, long: coordinate.longitude)
        
    }
    
    private func getNameOfLocation(lat:CLLocationDegrees,long:CLLocationDegrees) {
        
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



