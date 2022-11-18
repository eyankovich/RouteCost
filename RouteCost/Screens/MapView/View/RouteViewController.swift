//
//  RouteViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import MapKit

enum ScreenMapMode {
    case pinMap
    case searchBy
}

class RouteViewController: UIViewController, RoutePresenterProtocol {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var manualSelect: UIButton!
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewDestinationLabel: UILabel!
    @IBOutlet weak var startSearchButton: UIButton!
    @IBOutlet weak var profileButtob: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pointAlabel: UILabel!
    
    // MARK: - Variables
    var presenter: RoutePresenterViewProtocol?
    var frame = CGRect()
    var locationManager: LocationManager?
    var selectedPin: MKPlacemark? = nil
    var myLocation: CLLocation?
    var screenMapMode: ScreenMapMode = .searchBy
    
    // MARK: - Private variables
    private var isCameraAnimated: Bool = true
    
    // MARK: - Live cyckle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager()
        setupMapView()
        countButton.addTarget(nil, action: #selector(asd), for: .touchUpOutside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateMap()
        setupMapMode()
    }
    
    private let countButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.mainLightGray
        button.setTitle("Go", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(UIImage(systemName: "car")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(nil, action: #selector(getDirections), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Methods
    private func setupDownLableButton(mode: ScreenMapMode) {
        switch mode {
        case .pinMap:
            startSearchButton.isHidden = true
            profileButtob.isHidden = true
            searchBarView.backgroundColor = .secondaryLabel
            myLocationString()
            returnDistanceBeetwinLocations()
            searchBarView.addSubview(countButton)
            countButton.topAnchor.constraint(equalTo: searchBarView.topAnchor, constant: 25).isActive = true
            countButton.leftAnchor.constraint(equalTo: searchBarView.leftAnchor, constant: 20).isActive = true
            countButton.rightAnchor.constraint(equalTo: searchBarView.rightAnchor, constant: -20).isActive = true
            countButton.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: -25).isActive = true
        case .searchBy:
            startSearchButton.isHidden = false
            profileButtob.isHidden = false
            searchBarView.backgroundColor = .white
            countButton.removeFromSuperview()
        }
        
    }
    
    private func returnDistanceBeetwinLocations() {
        presenter?.returnDistance({ [weak self] distance in
            guard let self = self else { return }
            self.distanceLabel.text = distance
        })
    }
    
    private func myLocationString() {
        presenter?.returnMyLocation({ [weak self] locationString in
            guard let self = self else { return }
            self.pointAlabel.text = locationString
        })
    }
    
    private func setupMapMode() {
        switch screenMapMode {
        case .pinMap:
            self.pinImage.isHidden = false
            self.topView.isHidden = false
            self.setupDownLableButton(mode: .pinMap)
        case .searchBy:
            self.setupDownLableButton(mode: .searchBy)
            self.searchBarView.isHidden = false
            self.pinImage.isHidden = true
            self.topView.isHidden = true
        }
    }
    
    private func setupMapView() {
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
    }
    
    private func updateMap() {
        locationManager?.newlocation.bind({ [weak self] location in
            guard let self = self else { return }
            guard let location = location else { return }
            self.mapView.centerToLocation(location)
            self.myLocation = location
        })
    }
    
    @objc func asd() {
        print("YAP")
    }
    
    @objc func getDirections() {
        presenter?.getDirection(mapView: mapView, selectedPin: selectedPin, myLocation: myLocation)
    }
    
    // MARK: - IBOutlets
    @IBAction func profileButtonWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func startSearch(_ sender: Any) {
        presenter?.viewDidLoad()
    }
    
    @IBAction func manualSelectAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            screenMapMode = .pinMap
            setupMapMode()
        } else {
            screenMapMode = .searchBy
            setupMapMode()
        }
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
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

extension RouteViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.tintColor = UIColor.systemOrange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30.0, height: 30.0)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(systemName: "car"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if screenMapMode == .pinMap {
            let location = CLLocation(latitude: mapView.centerCoordinate.latitude,
                                      longitude: mapView.centerCoordinate.longitude)
            self.selectedPin = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude,
                                                                              longitude: mapView.centerCoordinate.longitude))
            presenter?.returnLocationString(location, { [weak self] locationString in
                guard let self = self else { return }
                self.topViewDestinationLabel.text = locationString
            })
        }
    }
}
