//
//  ResultViewBottomSheetProtocol.swift
//  RouteCost
//
//  Created by Егор Янкович on 16.11.22.
//

import Foundation

protocol ResultViewBottomSheetProtocol {
    var presenter: ResultViewBottomSheetViewProtocol? { get set }
}

protocol ResultViewBottomSheetViewProtocol {
    var view: ResultViewBottomSheetProtocol { get set }
    init(view: ResultViewBottomSheetProtocol)
}
