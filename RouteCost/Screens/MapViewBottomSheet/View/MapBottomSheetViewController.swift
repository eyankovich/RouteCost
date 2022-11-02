//
//  MapBottomSheetViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit

class MapBottomSheetViewController: UIViewController, UISearchResultsUpdating, MapBottomViewPresenterProtocol {
    
    // MARK: - @IBOutlet variables
    @IBOutlet weak var currentLocationPlaceLabel: UILabel!
    
    // MARK: - Variables
    let searchVC = UISearchController(searchResultsController: SearchResultViewController())
    var presenter: MapBottomViewPresenterViewProtocol?
    
    // MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        navigationItem.searchController = searchVC
        navigationItem.title = "Find your place"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.returnMyLocation({ [weak self] location in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currentLocationPlaceLabel.text = location
            }
        })
    }
    
    // MARK: - Methods
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.updateSearchResults(for: searchController)
    }
}
