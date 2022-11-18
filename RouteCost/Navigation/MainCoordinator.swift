//
//  MainCoordinator.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
}

class MainCoorinator: Coordinator {
    
    // MARK: - Variables
    let tabBarController = TabBarController()
    var navigationController: UINavigationController?
    var window: UIWindow
    
    // MARK: - Initializators
    init(window: UIWindow) {
        self.window = window
    }
    
    //MARK: - Methods
    func start() {
        let mapVC =  ModulBuilder.shared.showRouteViewController()
        window.rootViewController = mapVC.view
        let view = mapVC.view
        view.presenter?.showBottomSheet = {
            let detailViewController = ModulBuilder.shared.showMapBottomViewSheet(delegate: mapVC.view)
            let nav = UINavigationController(rootViewController: detailViewController.view)
            nav.modalPresentationStyle = .pageSheet
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
            view.present(nav, animated: true, completion: nil)
        }
    }
}
