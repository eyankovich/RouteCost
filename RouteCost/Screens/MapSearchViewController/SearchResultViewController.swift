//
//  SearchResultViewController.swift
//  RouteCost
//
//  Created by Егор Янкович on 10.10.22.
//

import UIKit
import MapKit

class SearchResultViewController: UIViewController {
    
    // MARK: - @IBOutlet Variables
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let cellId = "RouteCellTableViewCell"
    var handleMapSearchDelegate: HandleMapSearch? = nil

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
        self.handleMapSearchDelegate = self
    }
    
    public func update(with places: [MKMapItem]) {
        self.places = places
        tableView.reloadData()
    }
 }

// MARK: - Extensions
extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RouteCellTableViewCell
        cell.cellTitleLabel.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = places[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

