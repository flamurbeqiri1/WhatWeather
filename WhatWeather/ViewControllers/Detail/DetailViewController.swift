//
//  DetailViewController.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    // force unwrap this property because this screen should always have data
    var currentWeather: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // little hack to allow the swiping
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        updateUI()
    }

    fileprivate func updateUI() {
        self.windLabel.text = "\(currentWeather.wind.speed)"
        self.temperatureLabel.text = "\(currentWeather.main.temp)"
        self.backgroundImageView.image = currentWeather.main.temp > 11.0 ? UIImage(named: "Sunny") : UIImage(named: "Rainy")
    }

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
