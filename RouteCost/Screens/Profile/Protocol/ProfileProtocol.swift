//
//  ProfileProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import Foundation

protocol ProfilePresenterProtocol {
    var presenter: ProfilePresenterViewProtocol? { get set }
}

protocol ProfilePresenterViewProtocol {
    var view: ProfilePresenterProtocol { get set }
    
    init(view: ProfilePresenterProtocol) 
}

