//
//  WeatherService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

protocol WeatherService {
    func listSeveralCities(completion: @escaping (Result<[Location]>) -> Void)
    func getImage(from location: Location, completion: @escaping (Result<UIImage>) -> Void)
}
