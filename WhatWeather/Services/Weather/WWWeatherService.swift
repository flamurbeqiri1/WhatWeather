//
//  WWWeatherService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

class WWWeatherService: WeatherService {

    private let backendService: BackendService
    private let imageLoadingService: ImageLoadingService

    let citiesUrl = "\(baseUrl)\(apiVersion)/group?id=2950159,2867714,2925533,2629691&units=\(units)&appid=\(apiKey)"

    init(backendService: BackendService, imageLoadingService: ImageLoadingService) {
        #if DEBUG
        print("DEBUG: Start WWWeatherService")
        #endif
        self.backendService = backendService
        self.imageLoadingService = imageLoadingService
    }

    deinit {
        #if DEBUG
        print("DEBUG: Stop WWWeatherService")
        #endif
    }

    func listSeveralCities(completion: @escaping (Result<[Location]>) -> Void) {
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

    func getImage(from location: Location, completion: @escaping (Result<UIImage>) -> Void) {
        guard let iconCode = location.weather.first?.icon else {
            completion(Result.failure(MockWeatherServiceError.noImage))
            return
        }
        guard let url = URL(string: getUrl(from: iconCode)) else {
            completion(Result.failure(MockWeatherServiceError.urlNotFound))
            return
        }
        self.imageLoadingService.loadImage(from: url) { (result) in
            switch result {
            case .success(let image):
                completion(Result.success(image))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }

}

// MARK: - Helpers

extension WWWeatherService {

    func getUrl(from code: String) -> String {
        // example url: http://openweathermap.org/img/wn/10d@2x.png
        return "\(imageBaseUrl)\(code)@2x.png"
    }
}
