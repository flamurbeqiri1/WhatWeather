//
//  LocationCellView.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

@IBDesignable public class LocationCellView: XibControl {

    var nibName = String(describing: LocationCellView.self)

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!

    @IBInspectable public var cityTitle: String? = nil {
        didSet {
            cityLabel?.text = cityTitle
            cityLabel?.isHidden = cityTitle?.isEmpty ?? true
        }
    }

    @IBInspectable public var cityTitleColor: UIColor {
        get {
            return cityLabel.textColor
        }
        set {
            cityLabel.textColor = newValue
        }
    }

    @IBInspectable public var countryTitle: String? = nil {
        didSet {
            countryLabel?.text = countryTitle
            countryLabel?.isHidden = countryTitle?.isEmpty ?? true
        }
    }

    @IBInspectable public var countryTitleColor: UIColor {
        get {
            return countryLabel.textColor
        }
        set {
            countryLabel.textColor = newValue
        }
    }

    @IBInspectable public var temperature: String? = nil {
        didSet {
            temperatureLabel?.text = temperature
            temperatureLabel?.isHidden = temperature?.isEmpty ?? true
        }
    }

    @IBInspectable public var temperatureTitleColor: UIColor {
        get {
            return temperatureLabel.textColor
        }
        set {
            temperatureLabel.textColor = newValue
        }
    }

    @IBInspectable public var backgroundImage: UIImage? = nil {
        didSet {
            backgroundImageView?.image = backgroundImage
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame, nibName: nibName)
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, nibName: nibName)
        setupView()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    private func setupView() {
        cityLabel.text = cityTitle
        cityLabel?.isHidden = cityTitle?.isEmpty ?? true
        countryLabel.text = countryTitle
        countryLabel?.isHidden = countryTitle?.isEmpty ?? true
        temperatureLabel.text = temperature
        temperatureLabel?.isHidden = temperature?.isEmpty ?? true
        backgroundImageView.image = backgroundImage
    }
}
