//
//  Dependency.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

// List all services that the app will use
protocol Dependency {
    func backendService() -> BackendService
    func weatherService() -> WeatherService
    func imageLoadingService() -> ImageLoadingService
}

class CoreDependency: Dependency {

    func backendService() -> BackendService {
        return MockBackendService()
    }

    func weatherService() -> WeatherService {
        return MockWeatherService()
    }

    func imageLoadingService() -> ImageLoadingService {
        return MockImageLoadingService()
    }
}

/// The singleton dependency container reference
/// which can be reassigned to another container
struct DependencyInjector {
    static var dependencies: Dependency = CoreDependency()
    private init() { }
}

/// Attach to any type for exposing the dependency container
protocol HasDependencies {
    var dependencies: Dependency { get }
}

extension HasDependencies {
    /// Container for dependency instance factories
    var dependencies: Dependency {
        return DependencyInjector.dependencies
    }
}

import UIKit

extension UIApplicationDelegate {
    func configure(dependency: Dependency) {
        DependencyInjector.dependencies = dependency
    }
}
