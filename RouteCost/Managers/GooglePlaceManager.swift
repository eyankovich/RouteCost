//
//  GooglePlaceManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.10.22.
//

import Foundation
import GooglePlaces

struct Place {
    let name: String
    let identifier: String
}

enum PlacesError: Error {
    case failedToFind
}

final class GooglePlacesManager {
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    public func findPlaces(query: String, completion: @escaping(Result<[Place], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        client.findAutocompletePredictions(fromQuery: query,
                                           filter: filter,
                                           sessionToken: nil) { results, error in
            guard let results = results, error == nil else {
                completion(.failure(PlacesError.failedToFind))
                return
            }
            let places: [Place] = results.compactMap({
                Place(name: $0.attributedFullText.string, identifier: $0.placeID)
            })
            completion(.success(places))
        }
    }

}
