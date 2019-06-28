//
//  MockWeatherService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

class MockWeatherService: WeatherService {

    var listOfCities: [Weather]!

    init() {
        print("Start MockWeatherService")
        listAllCities()
    }

    deinit {
        print("Stop MockWeatherService")
    }

    func listSeveralCities(completion: @escaping (Result<[Weather]>) -> Void) {
        // Simulate network latency
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(Result.success(self.listOfCities))
        }
    }

}

extension MockWeatherService {

    fileprivate func listAllCities() {
        listOfCities = [
            Weather(main: Main(temp: 24.27, tempMin: 22.22, tempMax: 27.78, pressure: 1023, humidity: 43),
                    sys: Sys(country: "DE"),
                    wind: Wind(speed: 2.6, deg: 300),
                    timeOfData: 1561730960,
                    cityId: 2950159,
                    name: "Berlin"),
            Weather(main: Main(temp: 27.73, tempMin: 26.0, tempMax: 30.0, pressure: 1022, humidity: 39),
                    sys: Sys(country: "DE"),
                    wind: Wind(speed: 2.1, deg: 330),
                    timeOfData: 1561730849,
                    cityId: 2867714,
                    name: "Muenchen"),
            Weather(main: Main(temp: 28.09, tempMin: 25.56, tempMax: 30.0, pressure: 1022, humidity: 21),
                    sys: Sys(country: "DE"),
                    wind: WhatWeather.Wind(speed: 4.6, deg: 30),
                    timeOfData: 1561730960,
                    cityId: 2925533,
                    name: "Frankfurt am Main")
        ]
    }
}
