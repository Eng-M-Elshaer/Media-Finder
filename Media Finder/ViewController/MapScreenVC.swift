//
//  MapScreenVC.swift
//  Authentication Module
//
//  Created by Mohamed Elshaer on 22/10/2021.
//  Copyright © 2021 Mohamed Elshaer. All rights reserved.
//

import UIKit
import MapKit

// MARK: - MapScreenVCDelegate Protocol.
protocol MapScreenVCDelegate: AnyObject {
    func setDelailLocationInAddress(delailsAddress: String, tag: Int)
}

class MapScreenVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    //MARK:- Propretites
    private let locationManager = CLLocationManager()
    weak var delegate: MapScreenVCDelegate?
    var tag = 0
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
    }
    
    //MARK:- Actions
    @IBAction func addressSubmitBtnTapped(_ sender: UIButton) {
        let address = userLocationLabel.text ?? ""
        delegate?.setDelailLocationInAddress(delailsAddress: address, tag: tag)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Private Methods
extension MapScreenVC {
    private func centerMapOnCurrentLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
            self.setAddressFrom(location: locationManager.location!)
        }
    }
    private func centerMapOnSpecificLocation() {
        let location = CLLocation(latitude: 30.096655, longitude: 31.662533)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        self.setAddressFrom(location: location)
    }
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorisation()
        } else {
            print("can not get your location!")
        }
    }
    private func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            centerMapOnSpecificLocation()
        case .restricted, .denied:
            print("can not get your location!")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("can not get your location!")
        }
    }
    private func setAddressFrom(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placeMarks, erorr) in
            if let erorr = erorr {
                print("erorr is \(erorr.localizedDescription)")
            }else if let firstPlaceMarks = placeMarks?.first {
                let detailsAddress = firstPlaceMarks.compactAddress
                self.userLocationLabel.text = detailsAddress
            }
        }
    }
}

//MARK:- MKMapViewDelegate
extension MapScreenVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        self.setAddressFrom(location: location)
    }
}
