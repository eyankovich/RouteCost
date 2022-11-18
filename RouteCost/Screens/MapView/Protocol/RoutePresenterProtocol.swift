//
//  RoutePresenterProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import CoreLocation
import MapKit

protocol RoutePresenterProtocol {
    var presenter: RoutePresenterViewProtocol? { get set }
}

protocol RoutePresenterViewProtocol {
    var view: RoutePresenterProtocol? { get set }
    var showBottomSheet: (() -> ())? { get set }
    init(view:RoutePresenterProtocol, locationManager: LocationManager)
    func viewDidLoad()
    func returnLocationString(_ location: CLLocation, _ completion: @escaping (String) -> Void)
    func returnMyLocation(_ completion: @escaping (String) -> Void)
    func returnDistance(_ completion: @escaping (String) -> Void)
    func getDirection(mapView: MKMapView,selectedPin: MKPlacemark?, myLocation: CLLocation?)
}
