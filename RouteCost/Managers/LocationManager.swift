//
//  LocationManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.10.22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: - Static variable
    
    
    // MARK: - Variables
    var locationManager = CLLocationManager()
    var newlocation = LocationBinder<CLLocation?>(nil)
    
    // MARK: - Init
    override init() {
        super.init()
        locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
    }
    
    // MARK: - Methods
    func updateLocation(_ location: CLLocation) {
        if location.speed > 0 {
        }
    }
    
    func myLocationDecoding() {
        
    }
}

// MARK: - Extensions
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationLast = locations.last else {
            return
        }
        newlocation.value = locationLast
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location failed by reason: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
            break
        case .denied:
            print("deined")
            break
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Status authorizedWhenInUse")
        case .authorized:
            print("Status authorized")

        @unknown default:
            fatalError()
        }
    }
}
