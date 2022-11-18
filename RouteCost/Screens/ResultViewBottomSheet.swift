//
//  ResultViewBottomSheet.swift
//  RouteCost
//
//  Created by Егор Янкович on 16.11.22.
//

import UIKit

class ResultViewBottomSheet: UIViewController, ResultViewBottomSheetProtocol {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var pointALabel: UILabel!
    @IBOutlet weak var pointBLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var routeImageLabel: UIImageView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Variables
    var presenter: ResultViewBottomSheetViewProtocol?
    let cellId = "ResultCellTableViewCell"

    // MARK: - Live style
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    // MARK: - Methods
    
    private func configureTable() {
        infoTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        infoTableView.delegate = self
        infoTableView.dataSource = self
    }
}

extension ResultViewBottomSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
