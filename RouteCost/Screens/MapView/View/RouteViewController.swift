//
//  RouteViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import MapKit


class RouteViewController: UIViewController, RoutePresenterProtocol {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBarView: UIView!
    
    // MARK: - Variables
    var presenter: RoutePresenterViewProtocol?
    var frame = CGRect()
    var locationManager: LocationManager?
    var selectedPin: MKPlacemark? = nil
    
    // MARK: - Private variables
    private var isCameraAnimated: Bool = true
    
    // MARK: - Live cyckle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager()
        self.mapView.showsUserLocation = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateMap()
    }
    
    // MARK: - Methods
    private func updateMap() {
        locationManager?.newlocation.bind({ [weak self] location in
            guard let self = self else { return }
            guard let location = location else { return }
            self.mapView.centerToLocation(location)
        })
    }
    // MARK: - IBOutlets
    @IBAction func profileButtonWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func startSearch(_ sender: Any) {
        presenter?.viewDidLoad()
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension RouteViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
           let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
















