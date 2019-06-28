//
//  MainTableViewController.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

private enum State {
    case loading
    case populated([Weather])
    case empty
    case error(Error)

    var currentCities: [Weather] {
        switch self {
        case .populated(let cities): return cities
        default: return []
        }
    }
}

private enum LocationSection: Int {
    case featured
    case recommended

    init?(indexPath: NSIndexPath) {
        self.init(rawValue: indexPath.section)
    }

    static var numberOfSections: Int { return 2 }
}

class MainTableViewController: UITableViewController, HasDependencies {

    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!

    // Services
    private lazy var weatherService: WeatherService = dependencies.weatherService()

    private var state = State.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }
    private var featuredCities: [Weather] {
        return state.currentCities.filter { $0.cityId == berlinCityId }
    }

    private var recommendedCities: [Weather] {
        return state.currentCities.filter { $0.cityId != berlinCityId }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        listSeveralCities()
    }

    private func setupUI() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }

    private func setFooterView() {
        switch state {
        case .error(let error):
            errorLabel.text = error.localizedDescription
            tableView.tableFooterView = errorView
        case .loading:
            tableView.tableFooterView = UIView()
        case .empty:
            tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = UIView()
        }
    }

    private func listSeveralCities() {
        refreshControl?.beginRefreshing()
        state = .loading
        self.weatherService.listSeveralCities { [weak self] result in
            guard let `self` = self else { return }
            self.refreshControl?.endRefreshing()
            switch result {
            case .success(let cities):
                guard !cities.isEmpty else {
                    self.state = .empty
                    return
                }
                var allCities = self.state.currentCities
                allCities.append(contentsOf: cities)
                self.state = .populated(allCities)
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        listSeveralCities()
    }

}

// MARK: - Navigation

extension MainTableViewController {

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }

}

// MARK: - Table view data source

extension MainTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return LocationSection.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = LocationSection(rawValue: section) else { fatalError("Only 2 sections allowed") }
        switch section {
        case .featured:
            return featuredCities.count
        case .recommended:
            return recommendedCities.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        guard let section = LocationSection(rawValue: indexPath.section) else { fatalError("Only 2 sections allowed") }
        let weatherData: Weather
        switch section {
        case .featured:
            weatherData = featuredCities[indexPath.row]
        case .recommended:
            weatherData = recommendedCities[indexPath.row]
        }
        configure(cell, with: weatherData)
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

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = LocationSection(rawValue: section) else { fatalError("Only 2 sections allowed") }
        switch section {
        case .featured:
            return featuredCities.count == 0 ? 0.1 : tableView.sectionHeaderHeight
        case .recommended:
            return recommendedCities.count == 0 ? 0.1 : tableView.sectionHeaderHeight
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.performSegue(withIdentifier: "showDetailWeather", sender: nil)
    }

    fileprivate func configure(_ cell: LocationTableViewCell, with weatherCityData: Weather) {
        cell.locationCellView.cityTitle = weatherCityData.name
        cell.locationCellView.countryTitle = weatherCityData.sys.country
        cell.locationCellView.temperature = "\(weatherCityData.main.temp)"
        cell.locationCellView.backgroundImage = weatherCityData.main.temp > 11.0 ? UIImage(named: "Sunny") : UIImage(named: "Rainy")
    }
}
