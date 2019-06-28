//
//  DetailViewController.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, HasDependencies {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    @IBOutlet weak var windIconImageView: UIImageView!

    // Services
    private lazy var weatherService: WeatherService = dependencies.weatherService()

    // force unwrap this property because this screen should always have data
    var currentWeather: Location!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // little hack to allow the swiping
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        updateUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.windLabel.center.y += 10
            self.windIconImageView.transform = CGAffineTransform(rotationAngle: 45.0)
        }, completion: nil)
    }

    fileprivate func updateUI() {
        self.windLabel.text = "\(currentWeather.wind.speed)"
        self.temperatureLabel.text = "\(currentWeather.main.temp)"
        self.backgroundImageView.image = currentWeather.main.temp > 11.0 ? UIImage(named: "Sunny") : UIImage(named: "Rainy")
        self.cityNameLabel.text = currentWeather.name
        self.cityDescriptionLabel.text = currentWeather.weather.first?.weatherDescription ?? ""
        self.weatherService.getImage(from: currentWeather) { (result) in
            switch result {
            case .success(let image):
                self.weatherImageView.image = image
            case .failure(let error):
                print(error) // TODO handle error
            }
        }
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
