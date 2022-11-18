//
//  CarManager.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.11.22.
//

import Foundation

enum FuelType {
    case petrol
    case diesel
    case lpg
    case cng
}

enum VehicleType {
    case passanger
    case truck
    case bus
}

struct VehicleProfile {
    var mark: String
    var model: String
    var type: VehicleType
    var consumption: Double
    var fuelType: FuelType
}

extension VehicleProfile {
   static let myCar = VehicleProfile(mark: "VW",
                                     model: "Golf",
                                     type: .passanger,
                                     consumption: 6.0,
                                     fuelType: .diesel)
}
