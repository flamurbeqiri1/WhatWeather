//
//  MockWeatherService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

enum MockWeatherServiceError: String {
    case noImage = "No image"
    case urlNotFound = "Url not found"
}

extension MockWeatherServiceError: LocalizedError {
    public var errorDescription: String? {
        return rawValue
    }
}

class MockWeatherService: WeatherService {

    var listOfCities: [Location]!

    init() {
        print("Start MockWeatherService")
        listAllCities()
    }

    deinit {
        print("Stop MockWeatherService")
    }

    func listSeveralCities(completion: @escaping (Result<[Location]>) -> Void) {
        // Simulate network latency
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(Result.success(self.listOfCities))
        }
    }

    func getImage(from location: Location, completion: @escaping (Result<UIImage>) -> Void) {
        // Simulate network latency
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("Get Campaign Logo Picture performed")
            guard let url = URL(string: "http://openweathermap.org/img/wn/10d@2x.png"),
                let image = UIImage(contentsOfFile: url.path) else {
                    completion(Result.failure(MockWeatherServiceError.noImage))
                    return
            }
            completion(Result.success(image))
        }
    }

}

extension MockWeatherService {

    fileprivate func listAllCities() {
        listOfCities = [
            Location(main: Main(temp: 24.27, tempMin: 22.22, tempMax: 27.78, pressure: 1023, humidity: 43),
                    sys: Sys(country: "DE"),
                    wind: Wind(speed: 2.6, deg: 300),
                    timeOfData: 1561730960,
                    cityId: 2950159,
                    name: "Berlin",
                    weather: [Weather(id: 500, weatherDescription: "light rain", icon: "10d")]),
            Location(main: Main(temp: 27.73, tempMin: 26.0, tempMax: 30.0, pressure: 1022, humidity: 39),
                    sys: Sys(country: "DE"),
                    wind: Wind(speed: 2.1, deg: 330),
                    timeOfData: 1561730849,
                    cityId: 2867714,
                    name: "Muenchen",
                    weather: [Weather(id: 500, weatherDescription: "light rain", icon: "10d")]),
            Location(main: Main(temp: 28.09, tempMin: 25.56, tempMax: 30.0, pressure: 1022, humidity: 21),
                    sys: Sys(country: "DE"),
                    wind: WhatWeather.Wind(speed: 4.6, deg: 30),
                    timeOfData: 1561730960,
                    cityId: 2925533,
                    name: "Frankfurt am Main",
                    weather: [Weather(id: 500, weatherDescription: "light rain", icon: "10d")])
        ]
    }
}
