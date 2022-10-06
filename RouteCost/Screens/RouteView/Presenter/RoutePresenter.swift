//
//  RoutePresenter.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import Foundation

class RoutePresenter: RoutePresenterViewProtocol {
    var view: RoutePresenterProtocol?
        
    required init(view: RoutePresenterProtocol) {
        self.view = view
    }
}
