//
//  TabBarController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: Live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        delegate = self
    }
    
    // MARK: - Methods
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: RouteViewController(), title: "Route", image: UIImage(systemName: "house.fill")),
            generateVC(viewController: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.fill"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 50
        let positionOnY: CGFloat = 0
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
                                                          y: tabBar.bounds.minX - positionOnY,
                                                          width: width, height: height),
                                      cornerRadius: height/2)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width/5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainLightGray.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
