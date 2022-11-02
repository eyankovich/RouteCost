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
    
    var view: MapBottomViewPresenterProtocol
    var networkService: ApiRequestManager
    var locationManager: LocationManager
    
    
    required init(view: MapBottomViewPresenterProtocol,
                  networkService: ApiRequestManager,
                  locationManager: LocationManager) {
        self.view = view
        self.networkService = networkService
        self.locationManager = locationManager
    }
    
    
    func returnMyLocation(_ completion: @escaping (String) -> Void) {
        locationManager.newlocation.bind { [weak self] location in
            guard let location = location else { return }
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
                guard let place = placemarks?.first, error == nil else {
                    completion("error")
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
                print(places)
            case .failure(let error):
                print(error)
            }
        }
    }
}
