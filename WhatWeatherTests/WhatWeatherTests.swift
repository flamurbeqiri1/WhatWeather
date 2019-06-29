//
//  WhatWeatherTests.swift
//  WhatWeatherTests
//
//  Created by Flamur Beqiri on 27/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import XCTest
@testable import WhatWeather

class WhatWeatherTests: XCTestCase, HasDependencies {
    
    private lazy var weatherService: WeatherService = dependencies.weatherService()
    private lazy var imageLoadingService: ImageLoadingService = dependencies.imageLoadingService()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DependencyInjector.dependencies = CoreDependency()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        DependencyInjector.dependencies = AppDependency()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Tests
    
    func testListSeveralCities() {
        let payloadExpectation = self.expectation(description: "Payload")
        self.weatherService.listSeveralCities { (result) in
            switch result {
            case .success(let returnedObject):
                XCTAssertNotNil(returnedObject)
                payloadExpectation.fulfill()
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetImage() {
        let location = Location(main: Main(temp: 27.73, tempMin: 26.0, tempMax: 30.0, pressure: 1022, humidity: 39),
                                        sys: Sys(country: "DE"),
                                        wind: Wind(speed: 2.1, deg: 330),
                                        timeOfData: 1561730849,
                                        cityId: 2867714,
                                        name: "Muenchen",
                                        weather: [Weather(id: 500, weatherDescription: "light rain", icon: "10d")])
        
        let payloadExpectation = self.expectation(description: "Payload")
        guard let iconCode = location.weather.first?.icon else {
            XCTAssertFalse(false, "weather icon nil")
            return
        }
        let url = URL(string: "http://openweathermap.org/img/wn/\(iconCode)@2x.png")!
        self.imageLoadingService.loadImage(from: url) { (result) in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
                payloadExpectation.fulfill()
            case .failure(let error):
                XCTAssert(false, error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

}
