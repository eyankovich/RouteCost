//
//  RouteViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import GoogleMaps


class RouteViewController: UIViewController, RoutePresenterProtocol {
    
    // MARK: - Variables
    var presenter: RoutePresenterViewProtocol?
    var frame = CGRect()
    
    // MARK: - Live cyckle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(configureGoogleMap())
        frame = view.bounds
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.viewDidLoad()
    }
    
    // MARK: - IBOutlet Variables
    
    
    // MARK: - Methods
    func configureGoogleMap() -> GMSMapView {
        let locationManager = LocationManager.shared
        GMSServices.setMetalRendererEnabled(true)
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.myLocation?.coordinate.latitude) ?? 0.0, longitude: (locationManager.myLocation?.coordinate.longitude)!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        return mapView
    }
}
