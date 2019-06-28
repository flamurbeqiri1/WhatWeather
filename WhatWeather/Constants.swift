//
//  Constants.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

public let baseUrl = "http://api.openweathermap.org/data/"

public let apiKey = "90877ffd7384513983a21e818d09d119"

public let apiVersion = "2.5"

/// For temperature in Fahrenheit use units=imperial
/// For temperature in Celsius use units=metric
/// Temperature in Kelvin is used by default, no need to use units parameter in API call
public let units = "metric"

public let berlinCityId = 2950159
