//
//  MapBottomSheetProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 1.11.22.
//

import UIKit
import MapKit


protocol MapBottomViewPresenterProtocol {
    var presenter: MapBottomViewPresenterViewProtocol? { get set }
}

protocol MapBottomViewPresenterViewProtocol {
    
    var view: MapBottomViewPresenterProtocol { get set }
    var networkService: ApiRequestManager { get set }
    func returnMyLocation(_ completion: @escaping (String) -> Void)
    func updateSearchResults(for searchController: UISearchController)
    init(view: MapBottomViewPresenterProtocol,
         networkService: ApiRequestManager,
         locationManager: LocationManager)
}
