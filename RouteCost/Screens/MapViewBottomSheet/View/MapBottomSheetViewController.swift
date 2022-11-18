//
//  MapBottomSheetViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 6.10.22.
//

import UIKit
import MapKit

class MapBottomSheetViewController: UIViewController, UISearchResultsUpdating, MapBottomViewPresenterProtocol, UISearchBarDelegate {
    
    
    // MARK: - @IBOutlet variables
    @IBOutlet weak var curentLocationView: UIView!
    @IBOutlet weak var currentLocationPlaceLabel: UILabel!
    @IBOutlet weak var destinatonLocationLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    // MARK: - Variables
    var presenter: MapBottomViewPresenterViewProtocol?
    let searchVC = UISearchController()
    var searchBarText: ((String) -> Void)?
    var searchViewController: SearchResultViewController?
    var destenationLocation: CLLocation?
    
    // MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.searchBar.delegate = self
        guard let presenter = presenter else {
            return
        }
        searchViewController = SearchResultViewController(delegate: presenter.mapDelegate)
        searchViewController?.handleSearchResultTapDelegate = self
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureCalculateButton()
        presenter?.returnMyLocation({ [weak self] location in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currentLocationPlaceLabel.text = location
            }
        })
    }
    
    @IBAction func calculateButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Methods
    private func configureCalculateButton() {
        self.calculateButton.isHidden = true
        self.calculateButton.setTitle("Calculate", for: .normal)
    }
    
    private func configureSearchBar() {
        let searchVC = UISearchController(searchResultsController: searchViewController)
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.backgroundColor = .clear
        searchVC.searchBar.delegate = self
        searchVC.searchBar.setImage(UIImage(systemName: "location.fill.viewfinder")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), for: .search, state: .normal)
        searchVC.searchBar.placeholder = "Search Point B"
        searchVC.searchBar.searchTextField.backgroundColor = .white
        searchVC.searchBar.barTintColor = .blue
        searchBarText = { searchText in
            searchVC.searchBar.text = searchText
        }
        navigationItem.searchController = searchVC
        navigationItem.title = "Find your place"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.updateSearchResults(for: searchController)
    }
}

extension MapBottomSheetViewController: HandleSearchResultTap {
    func getChoosenPlace(placemark: MKPlacemark) {
        searchBarText?(placemark.name ?? placemark.description)
        destenationLocation = placemark.location
        presenter?.returnDistance({ [weak self] distance in
            guard let self = self else { return }
            self.calculateButton.isHidden = false
            self.calculateButton.setTitle("\(distance) Calculate", for: .normal)
        })
    }
}
