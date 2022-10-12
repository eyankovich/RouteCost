//
//  LocationManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.10.22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
        
    // MARK: - Static variable
    static let shared = LocationManager()
    
    // MARK: - Init
    
    // MARK: - Variables
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var preciseLocationZoomLevel: Float = 15.0
    var approximateLocationZoomLevel: Float = 10.0
    var myLocation: CLLocation?
    
    private func launchLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    public func start() {
        launchLocation()
    }
}

extension LocationManager {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            myLocation = CLLocation(latitude: latitude, longitude: longitude)
        }
    }
    func locationManager( _ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
