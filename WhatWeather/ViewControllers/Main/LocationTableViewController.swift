//
//  MainTableViewController.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

private enum LocationSection: Int {
    case featured
    case recommended

    init?(indexPath: NSIndexPath) {
        self.init(rawValue: indexPath.section)
    }

    static var numberOfSections: Int { return 2 }
}

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableview()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return LocationSection.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        // Configure the cell...
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell else {
            return UITableViewCell()
        }
        guard let section = LocationSection(rawValue: section) else { fatalError("Only 2 sections allowed") }
        switch section {
        case .featured:
            cell.titleHeaderLabel.text = "Featured Location"
        case .recommended:
            cell.titleHeaderLabel.text = "Recommended Location"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: Helpers

extension MainTableViewController {

    fileprivate func setupTableview() {
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 43
    }
}
