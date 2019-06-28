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
    let list: [Weather]
}

// MARK: - List
struct Weather: Codable {
    let main: Main
    let sys: Sys
    let visibility: Int
    let wind: Wind
    let timeOfData, cityId: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case main, sys, visibility, wind, name
        case timeOfData = "dt"
        case cityId = "id"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

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
    let deg: Int
}