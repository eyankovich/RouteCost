//
//  RoutePresenter.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import GooglePlaces
import GoogleMaps

class RoutePresenter: RoutePresenterViewProtocol {
    
    var showBottomSheet: (() -> ())?
    
    // MARK: - Variables
    var view: RoutePresenterProtocol?
       
    // MARK: - Initializators
    required init(view: RoutePresenterProtocol) {
        self.view = view
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        showBottomSheet?()
    }

}
