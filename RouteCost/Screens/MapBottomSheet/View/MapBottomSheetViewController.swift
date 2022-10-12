//
//  MapBottomSheetViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit

class MapBottomSheetViewController: UIViewController, UISearchResultsUpdating {

    // MARK: - Variables
    var places = ["London", "NY", "Minsk", "Moscow" ]
    let searchVC = UISearchController(searchResultsController: SearchResultViewController())
    
    // MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        navigationItem.searchController = searchVC
        navigationItem.title = "Find your place"
    }

    // MARK: - Methods
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? SearchResultViewController else {
            return
    
        }
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
                print(places)
            case .failure(let error):
                print(error)
            }
        }
    }
}
