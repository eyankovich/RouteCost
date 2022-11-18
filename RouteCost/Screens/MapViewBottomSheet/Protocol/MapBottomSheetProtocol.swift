//
//  MapBottomSheetProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 1.11.22.
//

import UIKit
import CoreLocation
import MapKit

protocol MapBottomViewPresenterProtocol {
    var presenter: MapBottomViewPresenterViewProtocol? { get set }
    var destenationLocation: CLLocation? { get set }
}

protocol MapBottomViewPresenterViewProtocol {
    var view: MapBottomViewPresenterProtocol { get set }
    var networkService: ApiRequestManager { get set }
    var mapDelegate: HandleMapSearch { get set }
    func returnMyLocation(_ completion: @escaping (String) -> Void)
    func updateSearchResults(for searchController: UISearchController)
    func getDirection(mapView: MKMapView,selectedPin: MKPlacemark?, myLocation: CLLocation?)
    func returnDistance(_ completion: @escaping (String) -> Void)
    init(view: MapBottomViewPresenterProtocol,
         networkService: ApiRequestManager,
         locationManager: LocationManagerProtocol,
         mapDelegate: HandleMapSearch)
}
