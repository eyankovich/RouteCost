//
//  RoutePresenterProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import Foundation

protocol RoutePresenterProtocol {
    var presenter: RoutePresenterViewProtocol? { get set }
}

protocol RoutePresenterViewProtocol {
    var view: RoutePresenterProtocol? { get set }
    init(view:RoutePresenterProtocol)
}
