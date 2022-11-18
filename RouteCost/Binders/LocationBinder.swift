//
//  LocationBinder.swift
//  RouteCost
//
//  Created by Егор Янкович on 26.10.22.
//

import Foundation
import CoreLocation

class LocationBinder<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
