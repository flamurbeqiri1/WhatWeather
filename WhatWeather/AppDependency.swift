//
//  AppDependency.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

class AppDependency: CoreDependency {

    // MARK: Backend
    override func backendService() -> BackendService {
        return WWBackendService()
    }

    // MARK: Weather
    override func weatherService() -> WeatherService {
        return WWWeatherService(backendService: backendService())
    }
}
