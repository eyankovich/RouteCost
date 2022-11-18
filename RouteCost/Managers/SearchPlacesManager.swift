//
//  GooglePlaceManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.10.22.
//

import Foundation
import MapKit

struct Place {
    let name: String
    let identifier: String
}

enum PlacesError: Error {
    case failedToFind
}

final class PlacesManager {
    static let shared = PlacesManager()
    
    private init() {}
    
    public func findPlaces(query: String, completion: @escaping(Result<[MKMapItem], Error>) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { responce, error in
            
            guard let responce = responce, error == nil else {
                guard let error = error else { return }
                completion(.failure(error))
                return
            }
            completion(.success(responce.mapItems))
        }
    }
}

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

protocol HandleSearchResultTap {
    func getChoosenPlace(placemark: MKPlacemark)
}
