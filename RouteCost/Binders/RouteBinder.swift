//
//  RouteBinder.swift
//  RouteCost
//
//  Created by Егор Янкович on 17.11.22.
//

import Foundation

class RouteBinder<T> {
    typealias RouteListener = (T) -> Void
    private var routeListener: RouteListener?
    
    func bind(_ routeListener: RouteListener?) {
        self.routeListener = routeListener
    }
    
    var value: T {
        didSet {
            routeListener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
