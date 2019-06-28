//
//  WeatherResponse.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

// MARK: - Weather
struct WeatherResponse: Codable {
    let cnt: Int
    let list: [Location]
}

// MARK: - List
struct Location: Codable {
    let main: Main
    let sys: Sys
    let wind: Wind
    let timeOfData, cityId: Int
    let name: String
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case main, sys, wind, name, weather
        case timeOfData = "dt"
        case cityId = "id"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let description, icon: String
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let pressure: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Double
}
