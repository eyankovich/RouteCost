//
//  ProfilePresenter.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import Foundation

class ProfilePresenter: ProfilePresenterViewProtocol {
    var view: ProfilePresenterProtocol
    
    required init(view: ProfilePresenterProtocol) {
        self.view = view
    }
}
