//
//  RoutePresenter.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import MapKit

class RoutePresenter: RoutePresenterViewProtocol {
  
    
    // MARK: - Variables
    var view: RoutePresenterProtocol?
    var showBottomSheet: (() -> ())?
    let locationManager: LocationManager
    var pointA: CLLocation?
    var pointB: CLLocation?
    
    // MARK: - Initializators
    required init(view: RoutePresenterProtocol, locationManager: LocationManager) {
        self.view = view
        self.locationManager = locationManager
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        showBottomSheet?()
    }
    
    func returnLocationString(_ location: CLLocation, _ completion: @escaping (String) -> Void) {
        pointB = location
        self.locationManager.reverseGeocode(location) { locationString in
            completion(locationString)
        }
    }
    
    func returnMyLocation(_ completion: @escaping (String) -> Void) {
        locationManager.newlocation.bind { [weak self] location in
            guard let self = self else { return }
            guard let location = location else { return }
            self.pointA = location
            self.locationManager.reverseGeocode(location) { locationString in
                completion(locationString)
            }
        }
    }
    
    func returnDistance(_ completion: @escaping (String) -> Void) {
        locationManager.getDistanceBeetweenTwoPoints(pointA, pointB) { distance in
            completion(distance)
        }
    }
    
    func getDirection(mapView: MKMapView, selectedPin: MKPlacemark?, myLocation: CLLocation?) {
        locationManager.getDirection(mapView: mapView, selectedPin: selectedPin, myLocation: myLocation)
    }
    
}
