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
        window.rootViewController = RouteViewController()
        //window.rootViewController = tabBarController
    }
}
