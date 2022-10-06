//
//  RouteViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import MapKit

class RouteViewController: UIViewController, RoutePresenterProtocol {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    var presenter: RoutePresenterViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
