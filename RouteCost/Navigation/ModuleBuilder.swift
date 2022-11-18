//
//  ModuleBuilder.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import Foundation
import UIKit

class ModulBuilder {
    
    // MARK: - Variables
    static var shared = ModulBuilder()
    
    // MARK: - Methods
    // Method whitch return RouteViewController
    func showRouteViewController() -> (view: RouteViewController, presenter: RoutePresenter) {
        let view = RouteViewController()
        let presenter = RoutePresenter(view: view, locationManager: LocationManager())
        view.presenter = presenter
        return (view, presenter)
    }
    
    // Method whitch return ProfileViewController
    func showProfileViewController() -> (view: ProfileViewController, presenter: ProfilePresenter) {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        return(view, presenter)
    }
    // Method whitch return MapBottomSheetViewController
    func showMapBottomViewSheet(delegate: HandleMapSearch) -> (view: MapBottomSheetViewController, presenter: MapBottomViewPresenter) {
        let view = MapBottomSheetViewController()
        let networkService = ApiRequestManager()
        let locationManager = LocationManager()
        let presenter = MapBottomViewPresenter(view: view,
                                               networkService: networkService,
                                               locationManager: locationManager,
                                               mapDelegate: delegate)
        view.presenter = presenter
        return (view, presenter)
    }
    
    // Method whitch return ResultViewBottomSheetController
    func showResultViewBottomSheet(direction: Direction) -> (view: ResultViewBottomSheet, presenter: ResultViewBottomSheetPresenter) {
        let view = ResultViewBottomSheet()
        let presenter = ResultViewBottomSheetPresenter(view: view)
        view.presenter = presenter
        return (view, presenter)
    }
}
