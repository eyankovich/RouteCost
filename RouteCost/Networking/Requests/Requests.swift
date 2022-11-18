//
//  Requests.swift
//  RouteCost
//
//  Created by Егор Янкович on 1.11.22.
//

import Foundation
import CoreLocation

struct GooglePositionGeocoding: DataRequest {
    
    typealias Responce = [GoogleGeocodingModel]
    private let apiKey: String = ""
    var coordinate: CLLocation
    
    init(coordinate: CLLocation) {
        self.coordinate = coordinate
    }
    
    var url: String {
        let baseURL: String = "https://maps.googleapis.com"
        let path: String = "/maps/api/geocode/json"
        return baseURL + path
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var queryItems: [String : String] {
        return ["latlng": "\(coordinate.coordinate.latitude),\(coordinate.coordinate.longitude)",
                "location_type": "ROOFTOP",
                "result_type": "street_address",
                "key": apiKey]
    }
    
    func decode(_ data: Data) throws -> [GoogleGeocodingModel] {
        let decoder = JSONDecoder()
        let responce = try decoder.decode(GoogleGeocodingModel.self, from: data)
        return [responce]
    }
}
