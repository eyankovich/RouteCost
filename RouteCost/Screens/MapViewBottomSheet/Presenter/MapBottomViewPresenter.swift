//
//  MapBottomViewPresenter.swift
//  RouteCost
//
//  Created by Егор Янкович on 1.11.22.
//

import UIKit
import CoreLocation
import MapKit

class MapBottomViewPresenter: MapBottomViewPresenterViewProtocol {
    
    var pointA: CLLocation?
    var view: MapBottomViewPresenterProtocol
    var networkService: ApiRequestManager
    var locationManager: LocationManagerProtocol
    var mapDelegate: HandleMapSearch
    
    required init(view: MapBottomViewPresenterProtocol,
                  networkService: ApiRequestManager,
                  locationManager: LocationManagerProtocol,
                  mapDelegate: HandleMapSearch) {
        self.view = view
        self.networkService = networkService
        self.locationManager = locationManager
        self.mapDelegate = mapDelegate
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
    
    func getDirection(mapView: MKMapView, selectedPin: MKPlacemark?, myLocation: CLLocation?) {
        locationManager.getDirection(mapView: mapView, selectedPin: selectedPin, myLocation: myLocation)

    }
    
    func returnDistance(_ completion: @escaping (String) -> Void) {
        guard let pointB = view.destenationLocation else { return }
        locationManager.getDistanceBeetweenTwoPoints(pointA, pointB) { distance in
            completion(distance)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? SearchResultViewController else {
            return
            
        }
        PlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
