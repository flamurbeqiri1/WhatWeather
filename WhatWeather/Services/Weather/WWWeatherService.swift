//
//  WWWeatherService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

class WWWeatherService: WeatherService {

    private let backendService: BackendService

    let citiesUrl = "\(baseUrl)\(apiVersion)/group?id=2950159,2867714,2925533&units=\(units)&appid=\(apiKey)"

    init(backendService: BackendService) {
        #if DEBUG
        print("DEBUG: Start WWWeatherService")
        #endif
        self.backendService = backendService
    }

    deinit {
        #if DEBUG
        print("DEBUG: Stop WWWeatherService")
        #endif
    }

    func listSeveralCities(completion: @escaping (Result<[Weather]>) -> Void) {
        self.backendService.get(WeatherResponse.self, path: citiesUrl) { (result) in
            switch result {
            case .success(let response):
                let listOfCities = response.list.compactMap { $0 }
                completion(Result.success(listOfCities))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }

}
