//
//  RoutePresenterProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit

protocol RoutePresenterProtocol {
    var presenter: RoutePresenterViewProtocol? { get set }
}

protocol RoutePresenterViewProtocol {
    var view: RoutePresenterProtocol? { get set }
    var showBottomSheet: (() -> ())? { get set }
    init(view:RoutePresenterProtocol)
    func viewDidLoad()
 //   func configureGoogleMap() -> GMSMapView
}
