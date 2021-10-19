//
//  MapWithCurrentLocationVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 19/10/2021.
//  Copyright © 2021 Mohamed Elshaer. All rights reserved.
//

import UIKit
import MapKit

// MARK: - MapCenterDelegate Protocol.
protocol MapWithCurrentLocationDelegate {
    func setDelailLocationInAddress(delailsAddress: String, tag: Int)
}

class MapWithCurrentLocationVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    // MARK:- Properties
    private let locationManager = CLLocationManager()
    private let regionInMeters: Double = 10000
    private var previuosLocation: CLLocation?
    var delegate: MapWithCurrentLocationDelegate?
    var tag = 0
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:- Actions
    @IBAction func submitUserAddressBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK:- Private Methods
extension MapWithCurrentLocationVC {
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            self.showAlert(title: "Error", message: "Please Turn On Location Services")
        }
    }
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    private func startTrackingLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previuosLocation = getCenterLocation(for: mapView)
    }
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

// MARK:- CLLocationManagerDelegate
extension MapWithCurrentLocationVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

// MARK:- MKMapViewDelegate
extension MapWithCurrentLocationVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        guard self.previuosLocation != nil else { return }
        guard location.distance(from: previuosLocation ?? location) > 50 else {return}
        self.previuosLocation = location
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if error != nil {
            userLocationLabel.text = "Unable to Find Address for Location"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                userLocationLabel.text = placemark.compactAddress ?? ""
                delegate?.setDelailLocationInAddress(delailsAddress: placemark.compactAddress ?? "N/A", tag: tag)
            } else {
                userLocationLabel.text = "No Matching Addresses Found"
                delegate?.setDelailLocationInAddress(delailsAddress: "No Matching Addresses Found", tag: tag)
            }
        }
    }
}
