//
//  LocationManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.10.22.
//

import Foundation
import CoreLocation
import MapKit


protocol LocationManagerProtocol {
    var locationManager: CLLocationManager  { get set }
    var newlocation: LocationBinder<CLLocation?> { get set }
    var direction: Direction? { get set }
    var distance: String? { get set }
    var estimatedTime: String? { get set }
    func createDirection(pointA: CLLocation, pointB: CLLocation)
    func reverseGeocode(_ location: CLLocation, _ completion: @escaping (String) -> Void)
    func getDistanceBeetweenTwoPoints(_ locationA: CLLocation?, _ locationB: CLLocation?, _ completion: @escaping (String) -> Void)
    func getDirection(mapView: MKMapView,selectedPin: MKPlacemark?, myLocation: CLLocation?)
}

class LocationManager: NSObject, LocationManagerProtocol {
    
    // MARK: - Variables
    var locationManager = CLLocationManager()
    var newlocation = LocationBinder<CLLocation?>(nil)
    var direction: Direction?
    var distance: String?
    var estimatedTime: String?
    
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
    func createDirection(pointA: CLLocation, pointB: CLLocation) {
        let uuid = UUID().uuidString
        guard let distance = distance,
              let estimatedTime = estimatedTime
        else {
            return
        }
        
        let vehicle = VehicleProfile.myCar
        
        let direction = Direction(id: uuid,
                                  pointA: pointA.description,
                                  pointB: pointB.description,
                                  vehicle: vehicle,
                                  distance: distance,
                                  estimatedTime: estimatedTime,
                                  fuelValue: "10",
                                  moneySpent: "90")
        self.direction = direction
    }
    
    func reverseGeocode(_ location: CLLocation, _ completion: @escaping (String) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first, error == nil else {
                completion(error?.localizedDescription ?? "error")
                return
            }
            var placeName = ""
            if let locality = place.locality,
               let streetName = place.name,
               let country = place.country
            {
                placeName += " \(streetName), \(locality), \(country)"
            }
            completion(placeName)
        }
    }
    
    func getDistanceBeetweenTwoPoints(_ locationA: CLLocation?, _ locationB: CLLocation?, _ completion: @escaping (String) -> Void) {
        guard let pointA = locationA,
              let pointB = locationB else {
            return
        }
        let distance = pointA.distance(from: pointB)
        
        completion(String(Double(distance.rounded())))
    }
    
    func getDirection(mapView: MKMapView,selectedPin: MKPlacemark?, myLocation: CLLocation?) {
        if let selectedPin = selectedPin {
            let request = MKDirections.Request()
            guard let myLocation = myLocation else {
                return
            }
            let sourcePlaceMark = MKPlacemark(coordinate:
                                                CLLocationCoordinate2D(latitude: myLocation.coordinate.latitude,
                                                                       longitude: myLocation.coordinate.longitude))
            request.source = MKMapItem(placemark: sourcePlaceMark)
            let destPlaceMark = selectedPin
            request.destination = MKMapItem(placemark: destPlaceMark)
            request.transportType = [.automobile, .walking]
            let directions = MKDirections(request: request)
            directions.calculate { responce, error in
                guard let responce = responce else {
                    print("Error: \(error?.localizedDescription ?? "No error specified").")
                    return
                }
                for route in responce.routes {
                    print(route.expectedTravelTime)
                    mapView.addOverlay(route.polyline)
                    mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
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
