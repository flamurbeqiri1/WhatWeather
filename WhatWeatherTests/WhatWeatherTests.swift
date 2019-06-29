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
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
