//
//  SearchResultViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 2.11.22.
//

import UIKit
import MapKit

class SearchResultViewController: UITableViewController {
    
    // MARK: - Variables
    let cellId = "RouteCellTableViewCell"
    var handleMapSearchDelegate: HandleMapSearch
    var handleSearchResultTapDelegate: HandleSearchResultTap? = nil
    
    init(delegate: HandleMapSearch) {
        self.handleMapSearchDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Variables
    private var places: [MKMapItem] = []
    
    // MARK: - Live cykle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    // MARK: - Methods
    private func configureTable() {
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func update(with places: [MKMapItem]) {
        self.places = places
        tableView.reloadData()
    }
    
    // MARK: - Extensions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RouteCellTableViewCell
        cell.cellTitleLabel.text = places[indexPath.row].name
        cell.cityLabel.text = "\(places[indexPath.row].placemark.locality ?? ""), \(places[indexPath.row].placemark.country ?? "")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = places[indexPath.row].placemark
        handleSearchResultTapDelegate?.getChoosenPlace(placemark: selectedItem)
        handleMapSearchDelegate.dropPinZoomIn(placemark: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
